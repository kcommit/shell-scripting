#!/bin/bash

# Create a local class workspace

if [ "$#" -ne 1 ]
then
    echo "Usage: $0 CLASS_NAME" >&2
    exit 1
fi

class_name="$1"

if [ -z "$class_name" ]
then
    echo "Class name cannot be empty" >&2
    exit 1
fi

base_path="classroom/$class_name"

mkdir -p "$base_path/incoming" &&
mkdir -p "$base_path/processed" &&
mkdir -p "$base_path/reports" &&
{
    echo "Workspace ready: $base_path"
    exit 0
}

echo "Workspace setup failed: $base_path" >&2
exit 1
