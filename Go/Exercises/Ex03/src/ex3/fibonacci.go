package ex3

func FibSeq(n uint) uint {
	if n == 0 || n == 1 {
		return 1
	} else {
		return FibSeq(n-1) + FibSeq(n-2)
	}
}

func FibCon(n uint, ch chan uint) {
	if n == 0 || n == 1 {
		ch <- 1
		return
	}
	ch1 := make(chan uint, 1)
	ch2 := make(chan uint, 1)
	go FibCon(n-1, ch1)
	go FibCon(n-2, ch2)
	val1 := <-ch1
	val2 := <-ch2
	ch <- val1 + val2
	return
}

func Fib(n uint, cutoff uint) uint {
	if n < cutoff {
		return FibSeq(n)
	}
	var channel = make(chan uint, 1)
	FibCon(n, channel)
	return <-channel
}

func Fibonacci(n uint) uint {
	return Fib(n, 35)
}
