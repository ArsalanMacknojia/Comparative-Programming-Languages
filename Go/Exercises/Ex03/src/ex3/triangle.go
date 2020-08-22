package ex3

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

//-------------------------------------------------Go Interfaces--------------------------------------------------------

type Triangle struct {
	A, B, C Point
}

func (t Triangle) String() string {
	return fmt.Sprintf("[%s %s %s]", t.A, t.B, t.C)
}

func (t *Triangle) Scale(f float64) {
	(*t).A.Scale(f)
	(*t).A.Scale(f)
	(*t).B.Scale(f)
}

func (t *Triangle) Rotate(a float64) {
	(*t).A.Rotate(a)
	(*t).B.Rotate(a)
	(*t).C.Rotate(a)
}

type Transformable interface {
	Scale(f float64)
	Rotate(f float64)
}

func TurnDouble(t Transformable, angle float64) {
	t.Scale(2)
	t.Rotate(angle)
}

func main() {
	pt := Point{3, 4}
	TurnDouble(&pt, 3*math.Pi/2)
	fmt.Println(pt)
	tri := Triangle{Point{1, 2}, Point{-3, 4}, Point{5, -6}}
	TurnDouble(&tri, math.Pi)
	fmt.Println(tri)
}
