#!/bin/bash

# Check whether a homework file exists

read -r -p "Enter a filename: " filename

if [ -f "$filename" ]
then
    echo "Homework file found: $filename"
else
    echo "Homework file not found: $filename" >&2
fi
