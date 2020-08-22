package ex2

import(
	"fmt"
	"math"
)

type Point struct{
	x float64
	y float64
}

func NewPoint(x float64, y float64) Point{
	return Point{x, y}
}

//----------------------------------------------String Representation---------------------------------------------------

func (pt Point) String() string {
	return fmt.Sprintf("(%v, %v)", pt.x, pt.y)
}

//--------------------------------------------------Calculate Norm------------------------------------------------------

func (pt Point) Norm() float64 {
	return  math.Sqrt(pt.x*pt.x + pt.y*pt.y)
}

//-----------------------------------------------------Scale------------------------------------------------------------

func (pt *Point) Scale(f float64) {
	(*pt).x *= f
	(*pt).y *= f
}

//-----------------------------------------------------Rotate-----------------------------------------------------------

func (pt *Point) Rotate(a float64) {
	xVal := (*pt).x
	yVal := (*pt).y
	(*pt).x = xVal*math.Cos(a) - yVal*math.Sin(a)
	(*pt).y = xVal*math.Sin(a) + yVal*math.Cos(a)
}
