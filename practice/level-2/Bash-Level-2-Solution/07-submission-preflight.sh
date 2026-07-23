#!/bin/bash

# Validate a student submission before processing

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 STUDENT_NAME HOMEWORK_FILE" >&2
    exit 1
fi

student_name="$1"
homework_file="$2"

if [ -z "$student_name" ]
then
    echo "Student name cannot be empty" >&2
    exit 1
fi

if [[ "$student_name" == */* ]]
then
    echo "Student name cannot contain /" >&2
    exit 1
fi

if [ ! -f "$homework_file" ]
then
    echo "Homework file does not exist: $homework_file" >&2
    exit 1
fi

if [ ! -s "$homework_file" ]
then
    echo "Homework file is empty: $homework_file" >&2
    exit 1
fi

echo "Submission preflight passed"
exit 0
