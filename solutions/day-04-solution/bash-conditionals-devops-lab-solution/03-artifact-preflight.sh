#!/bin/bash

# Task 3 Solution
# Validate a release artifact before deployment.

if [[ "$#" -ne 1 ]]; then
    echo "Error: exactly one artifact path is required." >&2
    echo "Usage: $0 ARTIFACT" >&2
    exit 1
fi

artifact="$1"

if [[ -z "$artifact" ]]; then
    echo "Preflight failed: artifact path is empty." >&2
    exit 1
elif [[ ! -f "$artifact" ]]; then
    echo "Preflight failed: artifact is not a regular file: $artifact" >&2
    exit 1
elif [[ ! -r "$artifact" ]]; then
    echo "Preflight failed: artifact is not readable: $artifact" >&2
    exit 1
elif [[ ! -s "$artifact" ]]; then
    echo "Preflight failed: artifact is empty: $artifact" >&2
    exit 1
elif [[ "$artifact" != *.tar.gz ]]; then
    echo "Preflight failed: artifact must end with .tar.gz: $artifact" >&2
    exit 1
else
    echo "Artifact preflight passed: $artifact"
    exit 0
fi

