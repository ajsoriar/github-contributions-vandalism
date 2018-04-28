# ---------
# read v1
# ---------

# Source example:
# [week-num];[num-day-in-week];[commits-num];[author-name];[mail];[commit-message]
# 1;2;7;asr;mail-address;commit-message

clear

IFS=';'

file="./source.v2.txt"
while read -r f1 f2 f3 f4 f5 f6 f7 # f8
do

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else

                printf '%s, %s, %s, %s, %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6" "$f7" # "$f8"

        fi
        
done <"$file"

# Result example one week:
# 1, 1, 1, asr, mail-address, commit-message
# 1, 2, 7, asr, mail-address, commit-message
# 1, 3, 11, asr, mail-address, commit-message
# 1, 4, 5, asr, mail-address, commit-message
# 1, 5, 0, asr, mail-address, commit-message
# 1, 6, 1, asr, mail-address, commit-message
# 1, 7, 5, asr, mail-address, commit-message