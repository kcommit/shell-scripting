#!/bin/bash

# Title: User Creation Menu
# Purpose: Load a reusable function from another file and show a menu.
# Usage: bash service_action_menue.sh

# Find the directory where this master script is stored.
script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
function_file="$script_directory/create_user_function.sh"

# Confirm that the function library can be read.
if [[ ! -r "$function_file" ]]; then
    echo "Error: function file is not readable: $function_file" >&2
    exit 1
fi

# Load create_user() into the current Bash process.
# shellcheck source=create_user_function.sh
source "$function_file"

# Confirm that sourcing the file defined the expected function.
if ! declare -F create_user >/dev/null; then
    echo "Error: create_user function was not loaded." >&2
    exit 1
fi

# Keep showing the menu until the user chooses q.
while true
do
    echo

    if ! read -r -p "Create a new user? Enter y, n,: " action; then
        echo
        echo "Error: could not read the menu choice." >&2
        exit 1
    fi

    case "$action" in
        y|Y|yes|YES|Yes)
                        # Call the function instead of repeating its complete code.
                        if ! create_user; then
                            echo "The user-creation operation was not completed." >&2
                        fi
            ;;

        n|N|no|NO|No)
                    echo "Thanks for using me. Goodbye"
                    break
            ;;

        
        *)
            echo "Unknown action: $action" >&2
            ;;
    esac
done

exit 0
