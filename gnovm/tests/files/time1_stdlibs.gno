package main

import (
	"time"
)

func main() {
	t := time.Date(2009, time.November, 10, 23, 4, 5, 0, time.UTC)
	m := t.Minute()
	println(t, m)
}

// Output:
// 2009-11-10 23:04:05 +0000 UTC 4
