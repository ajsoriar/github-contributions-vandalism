# github-contributions-vandalism

This is a set of tools and scripts to do pixel-art in the contributions graph of github.

![github-contributions-vandalism examples](./06-web-js-create-image/demo/001.png?raw=true "github-contributions-vandalism examples")

### Steps:

#### [1] Create the image that you want to show in the contributions graph
Option 1) In order to create an image you can use: `/06-web-js-create-image/index.html` This option takes you right to step [3]
Option 2) Golang cmd tool. We need an image as a source.
The image should be: 52px (width or weeks) x 7px (height or days).
52 is a year so for sure it can be changed depending on your needs but 7px are mandatory or the result will be a mess. 


#### [2] Generate a coordinates file. It will be used to do commits.
2) In order to generate a file with the values needed to generate the git repo use: `/03-generate-coordinates-file-from-image`
You will find a golang script (img-to-txt.go) that needs the image generated in step 1 as a source.


#### [3] Creation of the repository doing lots of commits.
3) Finally, to generate the reository take the file generated in step 2 as a source of the shell script available here: `/05-create-repo-from-coordinates/do.v5.sh`
