#!/bin/bash

# Title: Multiplication Table Generator
# Purpose: Display the multiplication table of any number
# Usage: ./multiplication_table.sh NUMBER

read -r -p "Enter the required table number: " table

echo "===$table- Table==="

for var in {1..10}
do
	echo "$table x $var = $(($table*$var))"
done
