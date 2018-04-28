
# 4:this:aren't:the:droids:you're:looking:for:

#!/bin/bash

# ---------
# example 1
# ---------

file="./hello-data.txt"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
        # display fields using f1, f2,..,f7
        printf '%s, %s, %s\n' "$f1" "$f7" "$f6"
done <"$file"


#!/bin/bash

# ---------
# example 2
# ---------

file="./hello-data.txt"
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7 f8
do
        # display fields using f1, f2,..,f7
        printf '%s, %s, %s\n' "$f1" "$f7" "$f6"
done <"$file"