#!/bin/bash

# Skip empty lines while reading a student file

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 STUDENT_FILE" >&2
    exit 1
fi

student_file="$1"

if [ ! -f "$student_file" ]
then
    echo "Student file does not exist: $student_file" >&2
    exit 1
fi

student_count=0

while IFS= read -r student
do
    if [ -z "$student" ]
    then
        continue
    fi

    echo "Student: $student"
    student_count=$((student_count + 1))
done < "$student_file"

echo "Non-empty students: $student_count"
exit 0
