#!/bin/bash

# Process a validated student submission

if [ "$#" -ne 3 ]
then
    echo "Usage: $0 STUDENT_NAME HOMEWORK_FILE CLASS_WORKSPACE" >&2
    exit 1
fi

student_name="$1"
homework_file="$2"
class_workspace="$3"

if bash 07-submission-preflight.sh "$student_name" "$homework_file"
then
    echo "Preflight approved"
else
    echo "Submission processing stopped: preflight failed" >&2
    exit 1
fi

destination="$class_workspace/processed/$student_name"

mkdir -p "$destination" || {
    echo "Could not create destination: $destination" >&2
    exit 1
}

cp "$homework_file" "$destination/" || {
    echo "Could not copy homework file" >&2
    exit 1
}

final_path="$destination/$(basename "$homework_file")"
echo "Submission processed: $final_path"
exit 0
