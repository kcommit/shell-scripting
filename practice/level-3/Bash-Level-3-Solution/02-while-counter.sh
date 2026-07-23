#!/bin/bash

# Count from one to a supplied limit

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 POSITIVE_WHOLE_NUMBER" >&2
    exit 1
fi

limit="$1"
count=1

while [ "$count" -le "$limit" ]
do
    echo "Count: $count"
    count=$((count + 1))
done

echo "Counting completed"
exit 0
