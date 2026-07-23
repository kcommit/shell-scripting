#!/bin/bash

# Save command output in variables

current_user="$(whoami)"
today="$(date +%F)"
current_directory="$(pwd)"

echo "User: $current_user"
echo "Date: $today"
echo "Directory: $current_directory"
