
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
var_commit_message="My message"


# script

echo "[1] Be happy! We are about to create the repo: " ${var_repo_name}
git init ${var_repo_name}
cd ${var_repo_name}

#echo "[2] Create one file in this repo..." 
echo "/* ${var_repo_name} */" > ${var_file_name}

git add .

var_days=7
var_commits_per_day=3

# [3,5,7,11]

echo "go!"

for (( i=0; i <= $var_days; ++i ))
do


    # add day
    date -j -v +1d -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

    for (( j=0; j <= $var_commits_per_day; ++j ))
    do

        echo ${i} 
        #var_value= cat ${var_file_name} 
        echo ${i} ${j} $'\r' >> ${var_file_name}
        git add .

        date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

        # add minutes
        git commit -m "Commit num. ${i}, ${var_commit_message}" --date "${var_start_date}" --author="${var_author_name} <${var_author_mail}>"
    
    done

done

echo "done!"