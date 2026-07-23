#!/bin/bash

# Copy a homework file into a local directory

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 SOURCE_FILE DESTINATION_DIRECTORY" >&2
    exit 1
fi

source_file="$1"
destination_directory="$2"

if [ ! -f "$source_file" ]
then
    echo "Source file does not exist: $source_file" >&2
    exit 1
fi

mkdir -p "$destination_directory" || {
    echo "Could not create directory: $destination_directory" >&2
    exit 1
}

cp "$source_file" "$destination_directory/" || {
    echo "Could not copy file: $source_file" >&2
    exit 1
}

copied_path="$destination_directory/$(basename "$source_file")"
echo "Homework copied: $copied_path"
exit 0
