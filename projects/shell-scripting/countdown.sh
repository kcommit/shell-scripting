#!/bin/bash

# While  loop for study
#
#

count=5

while (( count >= 0 ))

do
    echo "$count"
    (( count -- ))
done

echo "Done!"
