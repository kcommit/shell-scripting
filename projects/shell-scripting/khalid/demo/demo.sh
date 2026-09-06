#!/bin/bash

# Learning variables and arrays

timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

# Create a new backup
zip -r backups/backup_"${timestamp}".zip data

# Load backups newest first
items=($(ls -t backups/backup_*.zip 2>/dev/null))

# Print number of backups
printf 'Total backups: %s\n' "${#items[@]}"

# Print all backups
printf '%s\n' "${items[@]}"

# If more than 5 backups exist
if [[ ${#items[@]} -gt 5 ]]; then

    echo "Backups after the latest 5:"

    # Get backups from index 5 to the end
    old_backups=("${items[@]:5}")

    # Print old backups
    printf '%s\n' "${old_backups[@]}"

    # Remove old backups
    for backup in "${old_backups[@]}"; do
        echo "Removing: ${backup}"
        rm -f -- "${backup}"
    done

fi
