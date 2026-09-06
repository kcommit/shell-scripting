#!/bin/bash
 

#Title: Count Error Lines
# Purpose: Count ERROR entries in a log file.

:xset -Eeou pipefail
#set -o pipefail
#set -u

echo "$0"

log_file="${1:-Guest}"

#log_file="$1"

grep "ERROR" "$log_file"

status=$(echo "$?")

echo "==== grep "ERROR" '$log_file'========"
echo "$status"


grep "ERROR" "$log_file" | wc -l

status=$(echo "$?")

echo "==== grep "ERROR" '$log_file' | wc -l ========"
echo "$status"


echo "Pipeline completed."

