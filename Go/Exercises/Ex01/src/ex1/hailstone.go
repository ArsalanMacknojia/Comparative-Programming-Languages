// Comparative Programming Languages
// Arsalan Macknojia

package ex1

//----------------------------------------------------Hailstone---------------------------------------------------------

func Hailstone(n uint) uint {
    if n%2 == 0 {
        n = n/2
    } else {
        n = (3*n)+1
    }
    return n
}

//------------------------------------------------Hailstone Sequence----------------------------------------------------

// Attempt 1: grow the slice
func HailstoneSequenceAppend(n uint) []uint {
    slice := []uint{}
    slice = append(slice, n)

    for n != 1 {
        n = Hailstone(n)
        slice = append(slice, n)
    }

    return slice
}

// Hailstone Length (Helper Function)
func HailstoneLength(n uint) int {
    length := 1

    for n != 1 {
        n = Hailstone(n)
        length += 1
    }

    return length
}


// Attempt 2: pre-allocate the array
func HailstoneSequenceAllocate(n uint) []uint {
    size := HailstoneLength(n)
    slice := make([]uint, size)

    for i := 0; i<size; i++ {
        slice[i] = n
        n = Hailstone(n)
    }

    return slice
}

//----------------------------------------------------Benchmark---------------------------------------------------------
//
// BenchmarkHailSeqAppend-12         429294              3095 ns/op
// BenchmarkHailSeqAllocate-12       925326              1364 ns/op
//
// HailstoneSequenceAppend takes 1.32 seconds to finish (429294 - operations * 3095 - seconds/operation)
// BenchmarkHailSeqAllocate takes 1.30 seconds to finish (925326 - operations * 1364 - seconds/operation)