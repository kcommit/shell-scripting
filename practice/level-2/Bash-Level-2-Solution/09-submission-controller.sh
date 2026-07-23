#!/bin/bash

# Control submission processing and append an audit record

if [ "$#" -ne 3 ]
then
    echo "Usage: $0 STUDENT_NAME HOMEWORK_FILE CLASS_WORKSPACE" >&2
    exit 1
fi

student_name="$1"
homework_file="$2"
class_workspace="$3"
current_time="$(date '+%F %T')"
current_user="$(whoami)"
audit_log="$class_workspace/submission-audit.log"

mkdir -p "$class_workspace" || {
    echo "Could not create class workspace: $class_workspace" >&2
    exit 1
}

if bash 08-submission-processor.sh "$student_name" "$homework_file" "$class_workspace"
then
    final_status="SUCCESS"
    echo "$current_time | user=$current_user | student=$student_name | file=$homework_file | status=$final_status" >> "$audit_log" || {
        echo "Could not write audit log" >&2
        exit 1
    }
    echo "Submission completed successfully"
    exit 0
else
    final_status="FAILED"
    echo "$current_time | user=$current_user | student=$student_name | file=$homework_file | status=$final_status" >> "$audit_log" || {
        echo "Could not write audit log" >&2
        exit 1
    }
    echo "Submission failed" >&2
    exit 1
fi
