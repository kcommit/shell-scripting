#!/bin/bash

# Title: Multiplication Table Generator
# Purpose: Display the multiplication table of any positive whole number
# Usage: ./multiplication_table.sh

read -r -p "Enter the required table number: " table

# Check whether read failed
if [[ $? -ne 0 ]]; then
    echo "Error: could not read the input." >&2
    exit 1
fi

# Check for empty input
if [[ -z "$table" ]]; then
    echo "Error: table number cannot be empty." >&2
    exit 1
fi

# Allow digits only
if [[ ! "$table" =~ ^[0-9]+$ ]]; then
    echo "Error: enter a positive whole number." >&2
    exit 1
fi

# Treat values such as 08 as decimal numbers
table_number=$((10#$table))

# Reject zero
if (( table_number == 0 )); then
    echo "Error: enter a number greater than zero." >&2
    exit 1
fi

echo "=== Table of $table_number ==="

for (( var = 1; var <= 10; var++ ))
do
    result=$((table_number * var))
    echo "$table_number x $var = $result"
done

exit 0
