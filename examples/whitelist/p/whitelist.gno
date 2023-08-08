package whitelist

import (
	"std"
	"time"
)

// setup whitelist, set deadline, maybe number of users?
// sign up for whitelist
// render out whitelisted users, only after deadline
// check if specific user is whitelisted

type Whitelist struct {
	name     string
	owner    std.Address
	deadline time.Time
	maxUsers int64
	active   bool
	userList []std.Address
}

func NewWhitelist(name string, deadline time.Time, maxUsers int64, owner std.Address) *Whitelist {
	return &Whitelist{
		name:     name,
		owner:    owner,
		deadline: deadline,
		maxUsers: maxUsers,
		active:   false,
		userList: make([]std.Address, 0),
	}
}

func (w *Whitelist) GetWhitelistName() string {
	return w.name
}

func (w *Whitelist) GetWhitelistOwner() std.Address {
	return w.owner
}

func (w *Whitelist) GetWhitelistDeadline() time.Time {
	return w.deadline
}

func (w *Whitelist) GetMaxUsers() int64 {
	return w.maxUsers
}

func (w *Whitelist) GetWhitelistActive() bool {
	return w.active
}

func (w *Whitelist) GetWhitelistedUsers() []std.Address {
	return w.userList
}

func (w *Whitelist) SetWhitelistActive(active bool) bool {
	w.active = active
	return w.active
}

// if user is already on specific whitelist, dont add them and return false
// if whitelist has exceeded deadline, dont add user and return false
func (w *Whitelist) AddUserToList(userToAdd std.Address) bool {
	if w.isOnWhitelist(userToAdd) {
		return false
	}

	if w.GetWhitelistDeadline().After(time.Now()) {
		return false
	}

	w.userList = append(w.userList, userToAdd)
	return true
}

func (w *Whitelist) CheckWhitelistActive() bool {
	return w.active
}

func (w *Whitelist) isOnWhitelist(userToCheck std.Address) bool {
	for _, user := range w.GetWhitelistedUsers() {
		if user.String() == userToCheck.String() {
			return true
		}
	}
	return false
}

// returns true if txSender is owner of ws
func (w *Whitelist) IsOwnerOfWhitelist(txSender std.Address) bool {
	return txSender == w.GetWhitelistOwner()
}
