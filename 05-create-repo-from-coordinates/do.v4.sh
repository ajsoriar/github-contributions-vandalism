
clear

echo "---------------" 
echo "- FUN!        -" 
echo "---------------" 
#sleep 1

# git contributions image

# init config vars

var_image="null" 
var_repo_name="my-repo-name"
#var_start_date="2012-01-01T12:00:01"
var_start_date="2012-01-01"
var_author_name="Author-of-repo-name"
var_author_mail="mail-address"
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
count_commmits_in_day=0

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

                var_commits_per_day="$f3"

                if (test  "${f3:0:1}" = '0' ); then continue ; # Exit in the case of 0 commits

                        continue ;
                else

                        count_days=`expr $count_days + 1` # days with 0 commits should be in the file! or the process will fail
                        count_commmits_in_day = 0;

                        #echo "--> ${var_commits_per_day} $f3"
                        #date -j -v +1d -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                        for (( j=0; j <= $var_commits_per_day; ++j )) # commits in a day
                        do
                                #count_commmits=`expr $count_commmits + 1`
                                #var_commit_message= "Commit number ${count_commmits}; ${var_commit_message}" 
                                #printf "\n${var_commit_message}"

                                count_commmits=`expr $count_commmits + 1`
                                count_commmits_in_day=`expr $count_commmits_in_day + 1`

                                #echo ${count_commmits} 
                                printf "\nCommit number ${count_commmits}. Commit message: '${var_commit_message}'\n"

                                # Write change to file
                                #echo ${count_commmits} ${j} $'\r' >> ${var_file_name}
                                echo ${count_commmits} $'\r' >> ${var_file_name}
                                git add .

                                # 1 - This works fine!
                                #date -j -v +1H -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                                # 2 - This works fine!
                                #var_increase_time="+60S"
                                #date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                                # 3 - This works fine!
                                #var_increase_time="+60S"
                                #var_date=$( date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )

                                # # 4 - This works fine!
                                # var_Ymd="2012-01-01" #date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%d
                                # #var_Ymd=date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%d
                                # var_HMS="12:00:00" #date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%H:%M:%S
                                # #var_date=$( date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )
                                # var_date=$( date -j -v +0S -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )

                                # 5 - This works fine!

                                # Get total seconds from 'count_days' and 'count_commmits_in_day' values
                                # 1 day will add 86400 seconds. 1 commit will add 60 seconds
                                var_increase_time=$((86400*$count_days+60*$count_commmits_in_day))

                                echo "var_increase_time: ${var_increase_time}"
                                var_Ymd=${var_start_date} #"2012-01-01"
                                var_HMS="12:00:00"
                                var_date=$( date -j -v +"$var_increase_time"S -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )
                                echo "commit date: ${var_date}"

                                # Do commit
                                git commit -m "Commit number ${count_commmits}; ${var_commit_message}" --date "${var_date}" --author="${var_author_name} <${var_author_mail}>"
                        done
                fi
        fi
        
done <"$file"

echo "done!"