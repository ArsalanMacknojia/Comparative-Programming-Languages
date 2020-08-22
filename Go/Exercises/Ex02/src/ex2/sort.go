package ex2

import (
	"math/rand"
)

// Partition the slice arr around a random pivot (in-place), and return the pivot location.
func partition(arr []float64) int {
	// Adapted from https://stackoverflow.com/a/15803401/6871666
	left := 0
	right := len(arr) - 1

	// Choose random pivot
	pivotIndex := rand.Intn(len(arr))

	// Stash pivot at the right of the slice
	arr[pivotIndex], arr[right] = arr[right], arr[pivotIndex]

	// Move elements smaller than the pivot to the left
	for i := range arr {
		if arr[i] < arr[right] {
			arr[i], arr[left] = arr[left], arr[i]
			left++
		}
	}

	// Place the pivot after the last-smaller element
	arr[left], arr[right] = arr[right], arr[left]
	return left
}

func InsertionSort(arr []float64) {
	for i := 1; i < len(arr); i++ {
		currVal := arr[i]
		index := i
		for index > 0 && arr[index-1] > currVal {
			arr[index] = arr[index-1]
			index--
		}
		arr[index] = currVal
	}
}

const insertionSortCutoff = 10000

func QuickSort(arr []float64) {
	arrLen := len(arr)
	if arrLen < 2 {
		// Do nothing
	} else if arrLen < insertionSortCutoff {
		InsertionSort(arr)
	} else {
		var lo = 0
		var hi = arrLen
		if lo < hi {
			split := partition(arr)
			QuickSort(arr[lo:split])
			QuickSort(arr[split:hi])
		}
	}
}




