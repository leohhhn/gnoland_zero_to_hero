package main

import (
	"time"
)

var dummy = 1

var t time.Time = time.Date(2007, time.November, 10, 23, 4, 5, 0, time.UTC)

func main() {
	t = time.Date(2009, time.November, 10, 23, 4, 5, 0, time.UTC)
	println(t.Clock())
}

// Output:
// 23 4 5
