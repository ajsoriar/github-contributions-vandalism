package main

import (
	"fmt"
	"image"
	"log"
	"os"
	"strconv"

	// Package image/jpeg is not used explicitly in the code below,
	// but is imported for its initialization side-effect, which allows
	// image.Decode to understand JPEG formatted images. Uncomment these
	// two lines to also understand GIF and PNG images:
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
)

func main() {
	// Decode the JPEG data. If reading from file, create a reader with

	reader, err := os.Open("hello-rgb-2x7-14.png")
	if err != nil {
		log.Fatal(err)
	}
	//defer reader.Close()

	m, _, err := image.Decode(reader)
	if err != nil {
		log.Fatal(err)
	}

	defer reader.Close()

	bounds := m.Bounds()

	// Calculate a 16-bin histogram for m's red, green, blue and alpha components.
	//
	// An image's bounds do not necessarily start at (0, 0), so the two loops start
	// at bounds.Min.Y and bounds.Min.X. Looping over Y first and X second is more
	// likely to result in better memory access patterns than X first and Y second.

	fmt.Printf("\n")
	fmt.Printf("bounds.Min.Y: %6s \n", bounds.Min.Y)
	fmt.Printf("bounds.Max.Y: %6s \n", bounds.Max.Y)
	fmt.Printf("bounds.Min.X: %6s \n", bounds.Min.X)
	fmt.Printf("bounds.Max.X: %6s \n", bounds.Max.X)
	fmt.Printf("\n")

	var colorRange = 1
	var pixelCont = 0

	for x := bounds.Min.X; x < bounds.Max.X; x++ {

		//fmt.Printf("y: %d \n", y)
		for y := bounds.Min.Y; y < bounds.Max.Y; y++ {

			pixelCont++

			r, g, b, a := m.At(x, y).RGBA()

			fmt.Printf("%v %v %v %v\n", r, g, b, a)

			// ---------------------
			// Write to file
			// ---------------------
			//str := strconv.Itoa(pixelCont) + ";" + strconv.Itoa(x+1) + ";" + strconv.Itoa(y+1) + ";" + strconv.Itoa(colorRange) + ";null;null;null"
			str := strconv.Itoa(pixelCont) + ";" + strconv.Itoa(x+1) + ";" + strconv.Itoa(y+1) + ";" + strconv.FormatUint(uint64(r), 10) + ";" + strconv.FormatUint(uint64(g), 10) + ";" + strconv.FormatUint(uint64(b), 10) + ";" + strconv.FormatUint(uint64(a), 10) + ";" + strconv.Itoa(colorRange) + ";null;null;null"
			writetofile(str)

		} // y
	} // x
} // main

/* ------------- */
/* WRITE TO FILE */
/* ------------- */

func writetofile(somethingToWrite string) {

	// https://golang.org/pkg/os/#OpenFile

	// If the file doesn't exist, create it, or append to the file
	f, err := os.OpenFile("./output.txt", os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal(err)
	}
	//if _, err := f.Write([]byte("appended some data\n")); err != nil {
	if _, err := f.Write([]byte(somethingToWrite + "\n")); err != nil {
		log.Fatal(err)
	}
	if err := f.Close(); err != nil {
		log.Fatal(err)
	}
}

/* ---------------- */
/* RGB TO GRAYSCALE */
/* ---------------- */

/*
App.ImageFilters.grayscale = function() {

    var canvas = document.getElementById("myCanvas");
    var ctx = canvas.getContext('2d');
    var imageData = ctx.getImageData(0,0,canvas.width, canvas.height);
    var data = imageData.data;

    for (var i = 0; i < data.length; i += 4) {
        var avg = (data[i] + data[i +1] + data[i +2]) / 3;
        data[i]     = avg; // red
        data[i + 1] = avg; // green
        data[i + 2] = avg; // blue
    }

    ctx.putImageData(imageData, 0, 0);
};
*/
