package whitelistfactory

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

func TestWhitelistFactory_NewWhitelistInstance(t *testing.T) {
	var (
		name     = "first whitelist!"
		deadline = time.Now().Add(15)
		maxUsers = 100
	)

	alice := testutils.TestAddress("alice")
	std.TestSetOrigCaller(alice)

	w := NewWhitelist(name, deadline, int64(maxUsers), alice)

}



func TestWhitelist_SetActive(t *testing.T) {
	var (
		name     = "first whitelist!"
		deadline = time.Now().Add(15)
		maxUsers = 100
	)

	alice := testutils.TestAddress("alice")
	std.TestSetOrigCaller(alice)

	w := NewWhitelist(name, deadline, int64(maxUsers), alice)

	if w.GetWhitelistActive() != false {
		t.Fatal("whitelist should be inactive")
	}

	w.SetWhitelistActive(true)

	if w.GetWhitelistActive() != true {
		t.Fatal("whitelist should be active")
	}
}
