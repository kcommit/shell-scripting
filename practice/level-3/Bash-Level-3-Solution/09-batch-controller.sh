#!/bin/bash

# Control batch processing and append an audit record

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 INPUT_DIRECTORY OUTPUT_DIRECTORY" >&2
    exit 1
fi

input_directory="$1"
output_directory="$2"
current_time="$(date '+%F %T')"
current_user="$(whoami)"

mkdir -p logs || {
    echo "Could not create logs directory" >&2
    exit 1
}

audit_log="logs/batch-audit.log"

if bash 08-batch-processor.sh "$input_directory" "$output_directory"
then
    final_status="SUCCESS"
    echo "$current_time | user=$current_user | input=$input_directory | output=$output_directory | status=$final_status" >> "$audit_log" || {
        echo "Could not write audit log" >&2
        exit 1
    }
    echo "Batch completed successfully"
    exit 0
else
    final_status="FAILED"
    echo "$current_time | user=$current_user | input=$input_directory | output=$output_directory | status=$final_status" >> "$audit_log" || {
        echo "Could not write audit log" >&2
        exit 1
    }
    echo "Batch failed" >&2
    exit 1
fi
