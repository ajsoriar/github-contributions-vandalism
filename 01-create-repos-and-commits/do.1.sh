
clear

echo "---------------" 
echo "- FUN!        -" 
echo "---------------" 

# git contributions image

# init config vars

var_image="null" 
var_repo_name="my-repo-name"
var_start_date="2012-01-01T12:00:01"
var_author_name="Author-of-repo-name"
var_author_mail="mail-address"
var_file_name="hello.txt"
var_commit_message="My message "


# script

echo "[1] Be happy! We are about to create the repo: " ${var_repo_name}
git init ${var_repo_name}
cd ${var_repo_name}

echo "[2] Create one file in this repo..." 
echo 0 > ${var_file_name}

git add .

var_days=7
var_weeks=50
var_day = 0

#$ git commit -a -m "my commit number 1" --date 2010-05-07T22:13:16 --author="Author Name <@po.com>"
git commit -am "Initial commit" --date "${var_start_date}" --author="${var_author_name} <${var_author_mail}>"


# [3,5,7,11]

echo "go!"

for (( i=1; i <= $var_days; ++i ))
do
    echo ${i} 
    echo ${i} $'\r' >> ${var_file_name}
    git add .
    git commit -m "${var_commit_message}" --date "${var_start_date}" --author="${var_author_name} <${var_author_mail}>"
done