#!/bin/bash

# Task 1 Solution
# Display the arguments received by the script.

echo "Deployment Argument Inspector"
echo "-----------------------------"
echo "Script name: $0"
echo "Application: $1"
echo "Environment: $2"
echo "Version: $3"
echo "Artifact: $4"
echo "Argument count: $#"
echo "All arguments using \$@: $@"
echo "All arguments using \$*: $*"

