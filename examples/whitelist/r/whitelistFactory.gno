package whitelistfactory

import (
	"bytes"
	"std"
	"time"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/ufmt"
	"gno.land/p/demo/whitelist"
)

var (
	whitelistTree *avl.Tree
)

func init() {
	whitelistTree = avl.NewTree()
}

func NewWhitelistInstance(name string, deadline int64, maxUsers int64) (int, string) {

	if deadline <= time.Now().Unix() {
		return -1, "deadline cannot be in the past"
	}

	txSender := std.GetOrigCaller()

	id := whitelistTree.Size() // what type?

	if maxUsers <= 0 {
		return -1, "Maximum number of users cannot be less than 1"
	}

	w := whitelist.NewWhitelist(name, time.Unix(deadline, 0), maxUsers, txSender)

	whitelistTree.Set(
		ufmt.Sprintf("%d", id),
		w,
	)

	return id, "successfully created whitelist!"
}

func SignUpToWhitelist(whitelistID int) string {

	id := ufmt.Sprintf("%d", whitelistID)

	txSender := std.GetOrigCaller()

	whiteListRaw, exists := whitelistTree.Get(id)

	if !exists {
		return "whitelist does not exist"
	}

	w, _ := whiteListRaw.(*whitelist.Whitelist)

	ddl := w.GetWhitelistDeadline()

	// error handling
	if w.IsOnWhitelist(txSender) {
		return "user already in whitelist"
	}

	if ddl.Unix() <= time.Now().Unix() {
		return "whitelist already closed :/"
	}

	if w.GetMaxUsers() <= int64(len(w.GetWhitelistedUsers())) {
		return "whitelist full"
	}

	w.AddUserToList(txSender)

	whitelistTree.Set(
		id,
		w,
	)

	return ufmt.Sprintf("successfully added user to whitelist %d", whitelistID)
}

func Render(path string) string {
	if path == "" {
		return renderHomepage()
	}

	return "unknown page"
}

func renderHomepage() string {
	var b bytes.Buffer

	b.WriteString("# Sign up to a Whitelist!\n\n")

	if whitelistTree.Size() == 0 {
		// No parties available
		b.WriteString("### No whitelists available currently!")

		return b.String()
	}

	// For each category, write the name
	whitelistTree.Iterate("", "", func(key string, value interface{}) bool {
		// Write out the whitelist details
		w := value.(*whitelist.Whitelist)
		ddl := w.GetWhitelistDeadline()

		b.WriteString(
			ufmt.Sprintf(
				"## Whitelist #%s: %s\n",
				key, // whitelist ID
				w.GetWhitelistName(),
			),
		)

		if ddl.Unix() > time.Now().Unix() {
			b.WriteString(
				ufmt.Sprintf(
					"Whitelist sign-ups close at: %s\n",
					w.GetWhitelistDeadline().Format("15:04:05 02.01.2006\n"),
				),
			)
		} else {
			b.WriteString(
				ufmt.Sprintf(
					"Whitelist sign-ups closed!\n",
				),
			)
		}

		b.WriteString(
			ufmt.Sprintf(
				"Maximum number of users in whitelist: %d\n\n",
				w.GetMaxUsers(),
			),
		)

		// Print whitelisted users
		if users := w.GetWhitelistedUsers(); len(users) > 0 {
			b.WriteString(
				ufmt.Sprintf("Currently whitelisted users: %d\n\n", len(users)),
			)

			for index, user := range users {
				b.WriteString(
					ufmt.Sprintf("#%d - %s  \n", index, user),
				)
			}
		} else {
			b.WriteString("No addresses are whitelisted currently\n")
		}

		b.WriteString("\n")

		// Continue iteration
		return false
	})

	return b.String()
}
