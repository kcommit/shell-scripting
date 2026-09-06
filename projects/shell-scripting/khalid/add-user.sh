#!/bin/bash

# Title: Fruit List
# Purpose: Print five fruits with item numbers.

fruits=("apple" "banana" "mango" "orange" "red cherry")
item_number=1

for fruit in "${fruits[@]}"
do
    useradd -m $fruit
    echo "$fruit added"
    #item_number=$((item_number + 1))
done

exit 0
