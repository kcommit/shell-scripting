#!/bin/bash

set -u

source "$./create_user.sh"

while true
do
    read -r -p "Do you create a new user ? enter y or n or for quit q: " action

    case "$action" in
        y)
            create_user
            ;;

        n)
            echo "Thanks for using...."
	    break
            ;;

        *)
            echo "Unknown action." >&2
            ;;
    esac
done
