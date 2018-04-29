
clear

echo "---------------" 
echo "- FUN!        -" 
echo "---------------" 
#sleep 1

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

# lineNum=0
# count=`expr $count + 1`

count_commmits=0
count_days=0

IFS=';'

pwd

ls -l

# 2;1;7;asr;mail-address;commit-message

file="../source.v2.txt"
while read -r f1 f2 f3 f4 f5 f6 #f7 # f8
do

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else
                
                printf "\n************************************************************\n"
                printf 'Data: %s, %s, %s, %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6"
                printf "Week %s, day %s has %s commits.\n" "$f1" "$f2" "$f3"
                printf "************************************************************\n"

                count_days=`expr $count_days + 1` # days with 0 commits should be in the file! or the process will fail

                var_commits_per_day="$f3"

                if (test  "${f3:0:1}" = '0' ); then continue ; # Exit in the case of 0 commits

                        continue ;
                else

                        #echo "--> ${var_commits_per_day} $f3"
                        #date -j -v +1d -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                        for (( j=0; j <= $var_commits_per_day; ++j )) # commits in a day
                        do

                                #count_commmits=`expr $count_commmits + 1`
                                #var_commit_message= "Commit number ${count_commmits}; ${var_commit_message}" 
                                #printf "\n${var_commit_message}"

                                count_commmits=`expr $count_commmits + 1`

                                #echo ${count_commmits} 
                                printf "\nCommit number ${count_commmits}. ${var_commit_message}\n"

                                # Write change to file
                                #echo ${count_commmits} ${j} $'\r' >> ${var_file_name}
                                echo ${count_commmits} $'\r' >> ${var_file_name}
                                git add .

                                #date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!
                                #date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01T12:00:01" +%Y-%m-%dT%H:%M:%S # This doesn't!
                                #var_increase_time = "+1H"
                                #date -j -v $var_increase_time -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!
                                date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                                # add minutes
                                #git commit -m "Commit number ${count_commmits}; ${var_commit_message}" --date "${var_start_date}" --author="${var_author_name} <${var_author_mail}>"
                        
                        done
                fi
        fi
        
done <"$file"

echo "done!"