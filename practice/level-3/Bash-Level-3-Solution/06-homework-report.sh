#!/bin/bash

# Report valid and empty homework files in a directory

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 INPUT_DIRECTORY" >&2
    exit 1
fi

input_directory="$1"

if [ ! -d "$input_directory" ]
then
    echo "Input directory does not exist: $input_directory" >&2
    exit 1
fi

total_files=0
valid_files=0
empty_files=0

for homework_file in "$input_directory"/*.txt
do
    [ -e "$homework_file" ] || continue
    total_files=$((total_files + 1))
    filename="$(basename "$homework_file")"

    if [ -s "$homework_file" ]
    then
        echo "$filename: VALID"
        valid_files=$((valid_files + 1))
    else
        echo "$filename: EMPTY"
        empty_files=$((empty_files + 1))
    fi
done

echo "Total files: $total_files"
echo "Valid files: $valid_files"
echo "Empty files: $empty_files"
exit 0
