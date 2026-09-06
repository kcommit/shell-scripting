#!/bin/bash

# Title: User Creation
# Purpose: Create multiple local users with home directories.

usernames=("apple" "banana" "mango" "orange" "red_cherry")

if [[ "$EUID" -ne 0 ]]; then
    echo "Error: run this script with sudo or as root." >&2
    exit 1
fi

for username in "${usernames[@]}"
do
    if id "$username" &> /dev/null; then
        echo "Skipped: user already exists: $username"
        continue
    fi

    if useradd -m "$username"; then
        echo "User added successfully: $username"
    else
        echo "Error: could not create user: $username" >&2
        exit 1
    fi
done

exit 0
