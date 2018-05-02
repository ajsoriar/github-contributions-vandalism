# img-to-txt.go

In this folder you can find a script to transform images into text files.
You will need to instal golang: https://golang.org/
One pixel in the image will be a line in `output.txt`. 

The file looks like this:

    ```javascript
    ...
    8;2;1;61166;61166;61166;65535;0;null;null;null
    9;2;2;50886;58596;35466;65535;1;null;null;null
    10;2;3;31354;51914;28527;65535;2;null;null;null
    11;2;4;9252;39578;15163;65535;3;null;null;null
    12;2;5;6682;24672;10023;65535;4;null;null;null
    ...
    ```

The meaning is:

    index, x, y, R, G, B, A, tone, null, null, null

The file `output.txt` will be used to generate git commits. 

You can't use whatever kind of image, you need one with special characteristics.
The image should have 7 pixels in height. (Seven days are in week)
And 52 pixels in width that represent weeks.

The key value is `tone`, 

    ```javascript
    Tone:
    0   No commits! 	238, 238, 238
    1		=1	    	198, 228, 138
    2		=3		    122, 202, 111
    3		=5		    36,  154, 59
    4		=7		    26,  96,  39
    ```

### To run this example in the console, do this:

    go run ./img-to-txt.go

### To run the script seting imput and output as params:

    go run ./img-to-txt.go input.png output.txt


