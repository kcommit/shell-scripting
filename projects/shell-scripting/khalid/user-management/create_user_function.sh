#!/bin/bash

# Title: Create User Function Library
# Purpose: Provide the reusable create_user function.
# Important: This file defines the function but does not call it.

create_user()
{
    local username
    local initial_password

    # Read a username; return failure if input cannot be read.
    if ! read -r -p "Enter username: " username; then
        echo "Error: could not read the username." >&2
        return 1
    fi

    # Reject an empty username.
    if [[ -z "$username" ]]; then
        echo "Error: username cannot be empty." >&2
        return 1
    fi

    # Do not create an account that already exists.
    if id "$username" >/dev/null 2>&1; then
        echo "Error: user already exists: $username" >&2
        return 1
    fi

    # Temporary lab password; the user must change it at first login.
    initial_password="${username}@123"

    if ! sudo useradd -m -s /bin/bash -- "$username"; then
        echo "Error: user creation failed: $username" >&2
        return 1
    fi

    if ! printf '%s:%s\n' "$username" "$initial_password" | sudo chpasswd; then
        echo "Error: password assignment failed for: $username" >&2
        return 1
    fi

    if ! sudo chage -d 0 -- "$username"; then
        echo "Error: could not require a password change for: $username" >&2
        return 1
    fi

    # Verify and display the newly created account.
    id "$username"
    getent passwd "$username"

    echo "New user added: $username"
    echo "The user must change the password at first login."
    return 0
}

