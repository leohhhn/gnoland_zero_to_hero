package main

import (
	"gno.land/p/demo/testutils"
)

func main() {
	x := testutils.NewTestAccessStruct("PUB", "PRIV")
	println(x.PublicField)
}

// Output:
// PUB
