#!/bin/bash

# Validate a homework file

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 HOMEWORK_FILE" >&2
    exit 1
fi

homework_file="$1"

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

echo "Homework validation passed"
exit 0
