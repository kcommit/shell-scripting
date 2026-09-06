#!/bin/bash
#
#study exit
#

source_file="../abc.txt"

if [[ ! -f "$source_file" ]]; then
    echo "Error: source file does not exist." >&2
    exit 1
fi
echo  "$source_file exists"
bat "$source_file" && bash "$source_file"
exit 0



