#!/bin/bash

# Display every supplied fruit with a for loop

if [ "$#" -eq 0 ]
then
    echo "Usage: $0 FRUIT [FRUIT ...]" >&2
    exit 1
fi

for fruit in "$@"
do
    echo "Fruit: $fruit"
done

exit 0
