package ex3

import (
	"image"
	"image/color"
	"image/draw"
	"image/png"
	"os"
)

// Function draws a 200×200 PNG image with a circle.
func DrawCircle(outerRadius, innerRadius int, outputFile string) {
	file, _ := os.Create(outputFile)
	defer file.Close()

	bounds := image.Rectangle{Min: image.Point{}, Max: image.Point{X: 200, Y: 200}}
	grid := image.NewRGBA(bounds)
	white := color.RGBA{R: 255, G: 255, B: 255, A: 255}
	black := color.RGBA{A: 255}

	draw.Draw(grid, grid.Bounds(), &image.Uniform{C: white}, image.Point{}, draw.Src)

	x, y := 0, 0
	for y = 100-outerRadius; y <= 100+outerRadius; y++ {
		for x = 100-outerRadius; x <= 100+outerRadius; x++ {
			pos := ((x-100)*(x-100)) + ((y-100)*(y-100))
			if pos < (outerRadius*outerRadius) {
				grid.Set(x, y, black)
			}
		}
	}
	for y = 100-innerRadius; y <= 100+innerRadius; y++ {
		for x = 100-innerRadius; x <= 100+innerRadius; x++ {
			pos := ((x-100)*(x-100)) + ((y-100)*(y-100))
			if pos < (innerRadius*innerRadius) {
				grid.Set(x, y, white)
			}
		}
	}

	encodeError := png.Encode(file, grid)
	if encodeError != nil {
		panic(encodeError)
	}
}

func main ()  {
	DrawCircle(40, 20, "out.png")
}
