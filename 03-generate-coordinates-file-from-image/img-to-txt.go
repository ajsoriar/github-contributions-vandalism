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

	argsNum := len(os.Args)
	fmt.Println("Args num: ", argsNum)

	file1 := "./hello-rgb-2x7-14-github-colors.png"
	file2 := "./output.txt"

	if argsNum == 1 { // no params

	} else if argsNum == 2 { // Input file was provided

		file1 = os.Args[1]

	} else if argsNum == 3 { // Input and Output files were provided

		file1 = os.Args[1]
		file2 = os.Args[2]

	} else {

		// many parameters, do nothing!
	}

	fmt.Println("input file: ", file1)
	fmt.Println("output file: ", file2)

	// Decode the JPEG data. If reading from file, create a reader with

	reader, err := os.Open(file1)
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

	var colorRange = 0
	var pixelCont = 0
	var average = 0

	for x := bounds.Min.X; x < bounds.Max.X; x++ {

		//fmt.Printf("y: %d \n", y)
		for y := bounds.Min.Y; y < bounds.Max.Y; y++ {

			pixelCont++

			r, g, b, a := m.At(x, y).RGBA()

			average = (int(r) + int(g) + int(b)) / 3

			/*
				// github colors

				238, 238, 238
				198, 228, 138
				122, 202, 111
				36,  154, 59
				26,  96,  39

				R     G     B     A    (R+G+B/3)
				61166 61166 61166 65535 61166 			65535 - 61166 = 4369
				50886 58596 35466 65535 48316           61166 - 48316
				31354 51914 28527 65535 37265
				9252  39578 15163 65535 21331
				6682  24672 10023 65535 13792

			*/

			colorRange = 0

			// if ( 61166 + 4369 > average && average > 61166 - 4369 ) colorRange = 0
			// if ( 48316 + 4369 > average && average > 48316 - 4369 ) colorRange = 1
			// if ( 37265 + 4369 > average && average > 37265 - 4369 ) colorRange = 2
			// if ( 21331 + 4369 > average && average > 21331 - 4369 ) colorRange = 3
			// if ( 13792 + 4369 > average && average > 13792 - 4369 ) colorRange = 4

			// TODO: Allow grayscale images:
			// 5;1;5;54998;54998;54998;65535;0;null;null;null ( 54998 + 54998 + 54998 ) / 3 = 54998 // this should return 1 and returns 0
			// 10 3341 3084 3598 65535 3341 0 // this should return 5 and returns 0

			if 61166+4369 > average && average > 61166-4369 {
				colorRange = 0
			}
			if 48316+4369 > average && average > 48316-4369 {
				colorRange = 1
			}
			if 37265+4369 > average && average > 37265-4369 {
				colorRange = 2
			}
			if 21331+4369 > average && average > 21331-4369 {
				colorRange = 3
			}
			if 13792+4369 > average && average > 13792-4369 {
				colorRange = 4
			}

			fmt.Printf("%v %v %v %v %v %v %v\n", pixelCont, r, g, b, a, average, colorRange)

			// ---------------------
			// Write to file
			// ---------------------
			//str := strconv.Itoa(pixelCont) + ";" + strconv.Itoa(x+1) + ";" + strconv.Itoa(y+1) + ";" + strconv.Itoa(colorRange) + ";null;null;null"
			str := strconv.Itoa(pixelCont) + ";" + strconv.Itoa(x+1) + ";" + strconv.Itoa(y+1) + ";" + strconv.FormatUint(uint64(r), 10) + ";" + strconv.FormatUint(uint64(g), 10) + ";" + strconv.FormatUint(uint64(b), 10) + ";" + strconv.FormatUint(uint64(a), 10) + ";" + strconv.Itoa(colorRange) + ";null;null;null"
			writetofile(str, file2)

		} // y
	} // x
} // main

/* ------------- */
/* WRITE TO FILE */
/* ------------- */

func writetofile(somethingToWrite string, file2 string) {

	// https://golang.org/pkg/os/#OpenFile

	// If the file doesn't exist, create it, or append to the file
	f, err := os.OpenFile(file2, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
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
