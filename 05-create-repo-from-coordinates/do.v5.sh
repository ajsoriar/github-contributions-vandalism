
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
var_start_date="2013-01-06"
#var_author_name="Author-of-repo-name"
#var_author_mail="mail-address"

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

# 8;2;1;61166;61166;61166;65535;0;null;null;null
# 9;2;2;50886;58596;35466;65535;1;null;null;null
# 10;2;3;31354;51914;28527;65535;2;null;null;null
# 11;2;4;9252;39578;15163;65535;3;null;null;null
# 12;2;5;6682;24672;10023;65535;4;null;null;null

file="../source.v3.txt"
cat ${file}
while read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11
do

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else
                
                var_commits_per_day="0"

                if (test  "${f8}" = '0' ); then 
                        var_commits_per_day="0" 
                fi

                if (test  "${f8}" = '1' ); then 
                        var_commits_per_day="3"
                fi

                if (test  "${f8}" = '2' ); then 
                        var_commits_per_day="5"
                fi

                if (test  "${f8}" = '3' ); then 
                        var_commits_per_day="7"
                fi

                if (test  "${f8}" = '4' ); then 
                        var_commits_per_day="11"
                fi

                printf "\n***********************************************************************************\n"
                printf 'Data: %s, %s, %s, %s, %s, %s, %s, %s %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6" "$f7" "$f8" "$f9" "$f10" "$f11"
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

                        #echo "--> ${var_commits_per_day} $f3"
                        #date -j -v +1d -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%dT%H:%M:%S # This works!

                        for (( j=0; j < $var_commits_per_day; ++j )) # commits in a day
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
                                # var_Ymd="2012-01-01" #date -j -v "$var_increase_time" -f "%Y-%m-%d %qH:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%d
                                # #var_Ymd=date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%Y-%m-%d
                                # var_HMS="12:00:00" #date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "2012-01-01 12:00:00" +%H:%M:%S
                                # #var_date=$( date -j -v "$var_increase_time" -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )
                                # var_date=$( date -j -v +0S -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )

                                var_Ymd=${var_start_date} #"2012-01-01"
                                var_HMS="12:00:00"
                                var_date=$( date -j -v +"$var_increase_time"S -f "%Y-%m-%d %H:%M:%S" "$var_Ymd $var_HMS" +%Y-%m-%dT%H:%M:%S )
                                echo "commit date: ${var_date}"

                                # Do commit
                                git commit -m "Commit number ${count_commmits}; ${var_commit_message}" --date "${var_date}" --author="${var_author_name} <${var_author_mail}>"
                        done

                        # 5 - This works fine!

                        # Get total seconds from 'count_days' and 'count_commmits_in_day' values
                        # 1 day will add 86400 seconds. 1 commit will add 60 seconds
                        var_increase_time=$((86400*$count_days+60*$count_commmits_in_day))
                        echo "var_increase_time: ${var_increase_time}"
                fi
        fi
        
done <"$file"

echo "done!"