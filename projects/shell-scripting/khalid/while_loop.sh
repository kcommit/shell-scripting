#!/bin/bash

# While loop for study
#

count=1

while [[ $count -le 5 ]] 
do
    echo "$count"
    count=$((count += 1))
done
echo "End of the program"
