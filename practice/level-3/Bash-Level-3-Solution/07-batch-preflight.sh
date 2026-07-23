#!/bin/bash

# Validate every text file in an input batch

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
empty_files=0

for homework_file in "$input_directory"/*.txt
do
    [ -e "$homework_file" ] || continue
    total_files=$((total_files + 1))

    if [ ! -s "$homework_file" ]
    then
        echo "Empty file found: $homework_file" >&2
        empty_files=$((empty_files + 1))
    fi
done

echo "Preflight total files: $total_files"
echo "Preflight empty files: $empty_files"

if [ "$total_files" -eq 0 ]
then
    echo "Batch preflight failed: no .txt files found" >&2
    exit 1
fi

if [ "$empty_files" -gt 0 ]
then
    echo "Batch preflight failed: empty files detected" >&2
    exit 1
fi

echo "Batch preflight passed"
exit 0
