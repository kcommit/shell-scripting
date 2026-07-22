#!/bin/bash

# Task 4 Solution
# Check that the artifact is a readable, non-empty regular file.

if [[ "$#" -ne 1 ]]; then
    echo "Error: exactly one artifact path is required." >&2
    echo "Usage: $0 ARTIFACT" >&2
    exit 1
fi

artifact="$1"

if [[ ! -f "$artifact" ]]; then
    echo "Preflight failed: artifact is not a regular file: $artifact" >&2
    exit 1
elif [[ ! -r "$artifact" ]]; then
    echo "Preflight failed: artifact is not readable: $artifact" >&2
    exit 1
elif [[ ! -s "$artifact" ]]; then
    echo "Preflight failed: artifact is empty: $artifact" >&2
    exit 1
else
    echo "Preflight passed: $artifact"
    exit 0
fi

