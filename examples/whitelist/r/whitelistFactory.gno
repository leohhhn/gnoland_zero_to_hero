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
	whitelistList *avl.Tree
)

func init() {
	whitelistList = avl.NewTree()
}

// package and realm function names cannot be the same seemingly?
func NewWhitelistInstance(name string, deadline time.Time, maxUsers int64) (int, string) {

	// if deadline.Before(time.Now()) {
	// 	return _, "deadline must be in the future!"
	// }

	txSender := std.GetOrigCaller()

	id := whitelistList.Size() // what type?

	w := whitelist.NewWhitelist(name, deadline, maxUsers, txSender)

	whitelistList.Set(
		ufmt.Sprintf("%d", id),
		w,
	)

	return id, "successfully created whitelist!"
}

// func SignUpToWhitelist(whitelistID int) string {

// 	txSender := std.GetOrigCaller()

// 	id := ufmt.Sprintf("%d", whitelistID)

// 	whiteListRaw, exists := whitelistList.Get(id)
// 	if !exists {
// 		return "whitelist does not exist"
// 	}

// 	w, _ = whiteListRaw.(*whitelist.Whitelist)

// 	w.AddUserToList(txSender)

// 	whitelistList.Set(
// 		id,
// 		w,
// 	)

// 	return ufmt.Sprintf("successfully added user to whitelist %d", whitelistID)
// }

// `func Render(path string) string {
// 	if path == "" {
// 		return renderHomepage()
// 	}

// 	return "unknown page"
// }

func renderHomepage() string {
	var b bytes.Buffer

	b.WriteString("## Whitelist signup\n\n")

	if whitelistList.Size() == 0 {
		// No parties available
		b.WriteString("### No whitelists to sing up to currently!")

		return b.String()
	}

	// For each category, write the name
	whitelistList.Iterate("", "", func(key string, value interface{}) bool {
		// Write out the whitelist details
		whitelistList := value.(*whitelist.Whitelist)

		b.WriteString(
			ufmt.Sprintf(
				"## %s: %s - %s\n",
				key, // whitelist ID
				whitelist.GetWhitelistName(),
				whitelist.GetWhitelistDeadline().Format("02.01.2006. 15:04"),
			),
		)

		// Print guest list
		if users := party.GetWhitelistedUsers(); len(users) > 0 {
			b.WriteString(
				ufmt.Sprintf("### Whitelisted users: (%d)\n", len(users)),
			)

			for index, user := range users {
				b.WriteString(
					ufmt.Sprintf("#%d - %s\n", index, user),
				)
			}
		} else {
			b.WriteString("_Noone is whitelisted... yet_\n")
		}

		b.WriteString("\n")

		// Continue iteration
		return false
	})

	return b.String()
}
