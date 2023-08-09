package whitelist

import (
	"std"
	"testing"
	"time"

	"gno.land/p/demo/testutils"
)

// setup whitelist, set deadline, maybe number of users?
// sign up for whitelist
// render out whitelisted users, only after deadline
// check if specific user is whitelisted

func TestWhitelist_Setup(t *testing.T) {
	var (
		name     = "first whitelist!"
		deadline = time.Now().Add(15)
		maxUsers = 100
	)

	alice := testutils.TestAddress("alice")
	std.TestSetOrigCaller(alice)

	w := NewWhitelist(name, deadline, int64(maxUsers), alice)

	if w.GetWhitelistOwner() != alice {
		t.Fatal("invalid whitelist owner")
	}

	if w.GetMaxUsers() != maxUsers {
		t.Fatal("invalid max user number")
	}


	if w.GetWhitelistDeadline() != deadline {
		t.Fatal("invalid deadline")
	}

	if len(w.GetWhitelistedUsers()) != 0 {
		t.Fatal("invalid whitelisted user list")
	}
}

func TestWhitelist_CallerNotOwner(t *testing.T) {
	var (
		name     = "first whitelist!"
		deadline = time.Now().Add(15)
		maxUsers = 100
	)

	alice := testutils.TestAddress("alice")
	bob := testutils.TestAddress("bob")
	std.TestSetOrigCaller(alice)

	w := NewWhitelist(name, deadline, int64(maxUsers), alice)

	if w.IsOwnerOfWhitelist(bob) {
		t.Fatal("bob shouldn't be the owner of the whitelist")
	}
}


// FIXME: how to wait a block to test deadline?
// func TestWhitelist_ExceededDeadline(t *testing.T) {
// 	var (
// 		name     = "first whitelist!"
// 		deadline = time.Now()
// 		maxUsers = 100
// 	)

// 	alice := testutils.TestAddress("alice")
// 	std.TestSetOrigCaller(alice)

// 	w := NewWhitelist(name, deadline, int64(maxUsers), alice)

// 	// a block should pass by now?

// 	if w.AddUserToList(alice) {
// 		t.Fatal("deadline has been exceeded")
// 	}
// }
