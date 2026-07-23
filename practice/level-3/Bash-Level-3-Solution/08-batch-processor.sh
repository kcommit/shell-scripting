#!/bin/bash

# Copy every file from an approved batch

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 INPUT_DIRECTORY OUTPUT_DIRECTORY" >&2
    exit 1
fi

input_directory="$1"
output_directory="$2"

if bash 07-batch-preflight.sh "$input_directory"
then
    echo "Batch approved for processing"
else
    echo "Batch processing stopped: preflight failed" >&2
    exit 1
fi

mkdir -p "$output_directory" || {
    echo "Could not create output directory: $output_directory" >&2
    exit 1
}

processed_count=0

for homework_file in "$input_directory"/*.txt
do
    [ -e "$homework_file" ] || continue

    cp "$homework_file" "$output_directory/" || {
        echo "Could not copy file: $homework_file" >&2
        exit 1
    }

    echo "Processed: $(basename "$homework_file")"
    processed_count=$((processed_count + 1))
done

echo "Processed files: $processed_count"
exit 0
