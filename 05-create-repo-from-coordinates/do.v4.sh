
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


# ------------
# Create repo
# ------------

echo "[1] Be happy! We are about to create the repo: " ${var_repo_name}
git init ${var_repo_name}
cd ${var_repo_name}


# -----------------
# Add file to repo
# -----------------

#echo "[2] Create one file in this repo..." 
echo "/* ${var_repo_name} */" > ${var_file_name}
#git add .

# ---------------------------------
# Loop over days & commits per day
# ---------------------------------

i=0

IFS=';'

file="./source.v2.txt"
while read -r f1 f2 f3 f4 f5 f6 f7 # f8
do

        i++

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else

                printf '%s, %s, %s, %s, %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6" "$f7" # "$f8"

                $var_commits_per_day = $f3

                date -j -v +1d -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                for (( j=0; j <= $var_commits_per_day; ++j )) # commits in a day
                do

                        echo ${i} 
                        echo ${i} ${j} $'\r' >> ${var_file_name}
                        git add .

                        date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                        # add minutes
                        git commit -m "Commit num. ${i}, ${var_commit_message}" --date "${var_start_date}" --author="${var_author_name} <${var_author_mail}>"
                
                done

        fi
        
done <"$file"

echo "done!"