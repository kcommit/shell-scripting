#!/bin/bash

# Title: Count Error Lines
# Purpose: Count ERROR entries in a log file safely.

set -e
set -o pipefail
set -u

# Set up trap at the TOP before long-running commands like sleep
trap 'echo -e "\n[!] Script Interrupted by user" exit 130' INT

log_file="${1:-}"

# Check if file argument was provided
if [[ -z "$log_file" ]]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

# Print matching lines safely without crashing set -e if no matches are found
echo "--- Error Entries Found ---"
grep "ERROR" "$log_file" || echo "No ERROR entries found."

# Count matching lines cleanly using grep -c
error_count=$(grep -c "ERROR" "$log_file" || true)

echo "---------------------------"
echo "Total Error Lines: $error_count"
echo "Pipeline completed."
