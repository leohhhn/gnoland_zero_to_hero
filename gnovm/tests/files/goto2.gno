package main

func main() {
	if true {
		goto here
	here:
		println("ok")
		return
	}
}

// Output:
// ok
