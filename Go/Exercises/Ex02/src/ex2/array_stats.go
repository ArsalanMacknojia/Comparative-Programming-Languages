package ex2

import (
	"math"
	"math/rand"
	"time"
)

//-----------------------------------------------------Init-------------------------------------------------------------

func init() {
	rand.Seed(time.Now().UTC().UnixNano())
}

//-------------------------------------------------Random Array---------------------------------------------------------

func RandomArray(length int, maxInt int) []int {
	var randomArr []int
	for i := 0; i < length; i++ {
		randomArr = append(randomArr, rand.Intn(maxInt-1))
	}
	return randomArr
}

//----------------------------------------------Array Summary Stats-----------------------------------------------------

type SumStruct struct {
	x float64
	y float64
}

func CalculateSum(arr []int, sumChannel chan SumStruct) {
	var sum, sumSquare float64
	for i := 0; i < len(arr); i++ {
		sum += float64(arr[i])
		sumSquare += float64((arr[i]) * (arr[i]))
	}
	sumChannel <- SumStruct{sum, sumSquare}
}

func MeanStddev(arr []int, chunks int) (mean, stddev float64) {
	if len(arr)%chunks != 0 {
		panic("You promised that chunks would divide slice size!")
	}

	var sumChannel = make(chan SumStruct)
	var arrLen = len(arr)
	var chunkSize = arrLen / chunks

	for i := 0; i < chunks; i+=chunkSize {
		subArr := arr[i: i+chunkSize]
		go CalculateSum(subArr, sumChannel)
	}

	var sum float64 = 0
	var sumSquare float64 = 0

	for i := 0; i < chunks; i++ {
		partialSum := <-sumChannel
		sum += partialSum.x
		sumSquare += partialSum.y
	}

	mean = sum/float64(arrLen)

	x := sumSquare/float64(arrLen)
	y := mean*mean

	stddev = math.Sqrt(x - y)
	return
}
