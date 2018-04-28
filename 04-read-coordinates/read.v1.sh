# ---------
# read v1
# ---------

# Source example:
# [index]|[iso-date]|[yyy-mm-dd]|[hh|mm|ss]|[author-name]|[mail]|[commit-message]
# 3|2010-05-08T22:13:16|2012-12-31|22:13:16|asr|mail-address|commit-message

clear

IFS='|'

file="./source.v1.txt"
while read -r f1 f2 f3 f4 f5 f6 f7 # f8
do

        if (test  "${f1:0:1}" = '#' ) || ( test  "${f1:0:1}" = ''  ); then

                continue ;
        else

                printf '%s, %s, %s, %s, %s, %s, %s\n' "$f1" "$f2" "$f3" "$f4" "$f5" "$f6" "$f7" # "$f8"

        fi
        
done <"$file"

# Result example:
# 1, 2010-05-08T22:13:16, 2012-12-31, 22:13:16, asr, mail-address, commit-message
# 2, 2010-05-08T22:13:16, 2012-12-31, 22:13:16, asr, mail-address, commit-message
# 3, 2010-05-08T22:13:16, 2012-12-31, 22:13:16, asr, mail-address, commit-message
# 4, 2010-05-08T22:13:16, 2012-12-31, 22:13:16, asr, mail-address, commit-message
# mini:04-create-repo-from-coordinates asr$