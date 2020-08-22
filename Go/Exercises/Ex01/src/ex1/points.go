// Comparative Programming Languages
// Arsalan Macknojia

package ex1

import(
    "fmt"
    "math"
)

type Point struct{
    x float64
    y float64
}

func NewPoint(x float64, y float64) Point{
    newPoint := Point{x, y}
    return newPoint
}

//----------------------------------------------String Representation---------------------------------------------------

func (pt Point) String() string {
    return fmt.Sprintf("(%v, %v)", pt.x, pt.y)
}

//--------------------------------------------------Calculate Norm------------------------------------------------------

func (pt Point) Norm() float64 {
    return  math.Sqrt(pt.x*pt.x + pt.y*pt.y)
}