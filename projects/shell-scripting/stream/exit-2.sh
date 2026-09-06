#!/bin/bash
#
#
source_file="abc.txt"

if [[ -f "$source_file" ]]; then
    echo "File exist"
else
    echo "File does not exist"
fi
