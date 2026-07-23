#!/bin/bash

# Find a student and stop the loop after a match

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 STUDENT_NAME STUDENT_FILE" >&2
    exit 1
fi

target_student="$1"
student_file="$2"
found="no"

if [ ! -f "$student_file" ]
then
    echo "Student file does not exist: $student_file" >&2
    exit 1
fi

while IFS= read -r student
do
    echo "Checking: $student"

    if [ "$student" = "$target_student" ]
    then
        found="yes"
        echo "Student found: $student"
        break
    fi
done < "$student_file"

if [ "$found" = "yes" ]
then
    exit 0
else
    echo "Student not found: $target_student" >&2
    exit 1
fi
