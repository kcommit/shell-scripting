#!/bin/bash

# Task 4 Solution
# Check whether a required command is available.

if [[ "$#" -ne 1 ]]; then
    echo "Error: exactly one command name is required." >&2
    echo "Usage: $0 COMMAND" >&2
    exit 1
fi

tool="$1"

if command -v "$tool" > /dev/null 2>&1
then
    tool_path="$(command -v "$tool")"
    echo "Tool available: $tool"
    echo "Tool path: $tool_path"
    exit 0
else
    echo "Tool missing: $tool" >&2
    exit 1
fi

