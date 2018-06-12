# git contributions image

clear

echo "---------------" 
echo "- FUN!        -" 
echo "---------------" 


# init config vars

var_image="null" 
var_repo_name="my-repo-name"
var_start_date="2012-01-01"
var_author_name="asr"
var_author_mail="ajsoriar@gmail.com"
var_file_name="hello.txt"
var_commit_message="My default commit message"


# ------------
# Create repo
# ------------

echo "[1] Be happy! We are about to create the repo: " ${var_repo_name}
git init ${var_repo_name}
cd ${var_repo_name}


# -----------------
# Add file to repo
# -----------------

echo "/* ${var_repo_name} */" > ${var_file_name}


# ---------------------------------
# Loop over days & commits per day
# ---------------------------------

count_commmits=0
count_days=0
count_commmits_in_day=0

IFS=';'

pwd
ls -l

var_increase_time=$((1+60*$count_commmits_in_day))
echo "var_increase_time: ${var_increase_time}"

file="../source.v3.txt"
cat ${file}
while read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12
do

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else

                var_commits_per_day="0"

                if (test  "${f8}" = 'color-0' ); then 
                        var_commits_per_day="0" 
                fi

                if (test  "${f8}" = 'color-1' ); then 
                        var_commits_per_day="1"
                fi

                if (test  "${f8}" = 'color-2' ); then 
                        var_commits_per_day="4"
                fi

                if (test  "${f8}" = 'color-3' ); then 
                        var_commits_per_day="7"
                fi

                if (test  "${f8}" = 'color-4' ); then 
                        var_commits_per_day="11"
                fi

                printf "\n***********************************************************************************\n"
                printf 'Data: %s, %s, %s, %s, %s, %s, %s, %s %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6" "$f7" "$f8" "$f9" "$f10" "$f11" "$f11"
                printf "Day %s has %s commits.\n" "$f1" "$var_commits_per_day"
                printf "***********************************************************************************\n"

                count_days=`expr $count_days + 1` # days with 0 commits should be in the file! or the process will fail
                count_commmits_in_day="0";

                if (test  "${f8}" = '0' ); then 

                        # 5 - This works fine!

                        # Get total seconds from 'count_days' and 'count_commmits_in_day' values
                        # 1 day will add 86400 seconds. 1 commit will add 60 seconds
                        var_increase_time=$((86400*$count_days+60*$count_commmits_in_day))
                        echo "var_increase_time: ${var_increase_time}"

                        continue ; # Exit in the case of 0 commits
                else

                        for (( j=0; j < $var_commits_per_day; ++j )) # commits in a day
                        do
                                count_commmits=`expr $count_commmits + 1`
                                count_commmits_in_day=`expr $count_commmits_in_day + 1`
                                printf "\nCommit number ${count_commmits}. Commit message: '${var_commit_message}'\n"

                                # Write change to file
                                echo ${count_commmits} $'\r' >> ${var_file_name}
                                git add .

                                var_Ymd=${var_start_date} #"2012-01-01"
                                var_HMS="12:00:00"
                                var_date=$( date -j -v +"$var_increase_time"S -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )
                                echo "commit date: ${var_date}"

                                # Do commit
                                git commit -m "Commit number ${count_commmits}; ${var_commit_message}" --date "${var_date}" --author="${var_author_name} <${var_author_mail}>"
                        done

                        # Get total seconds from 'count_days' and 'count_commmits_in_day' values
                        # 1 day will add 86400 seconds. 1 commit will add 60 seconds
                        var_increase_time=$((86400*$count_days+60*$count_commmits_in_day))
                        echo "var_increase_time: ${var_increase_time}"
                fi
        fi
        
done <"$file"

echo "done!"