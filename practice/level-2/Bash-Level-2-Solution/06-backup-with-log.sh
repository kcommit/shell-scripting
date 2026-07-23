#!/bin/bash

# Create a timestamped backup and append a log record

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 SOURCE_FILE BACKUP_DIRECTORY" >&2
    exit 1
fi

source_file="$1"
backup_directory="$2"

if [ ! -f "$source_file" ]
then
    echo "Source file does not exist: $source_file" >&2
    exit 1
fi

mkdir -p "$backup_directory" || {
    echo "Could not create backup directory: $backup_directory" >&2
    exit 1
}

mkdir -p logs || {
    echo "Could not create logs directory" >&2
    exit 1
}

timestamp="$(date +%Y%m%d-%H%M%S)"
source_name="$(basename "$source_file")"
backup_file="$backup_directory/$timestamp-$source_name"

cp "$source_file" "$backup_file" || {
    echo "Backup copy failed" >&2
    exit 1
}

log_time="$(date '+%F %T')"
current_user="$(whoami)"

echo "$log_time | user=$current_user | source=$source_file | backup=$backup_file | status=SUCCESS" >> logs/backup.log || {
    echo "Could not write backup log" >&2
    exit 1
}

echo "Backup created: $backup_file"
exit 0
