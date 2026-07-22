#!/bin/bash

# Use double brackets with a fruit name containing a space

fruit="$1"

if [[ "$fruit" == "green apple" ]]
then
    echo "Green apple selected"
else
    echo "Different fruit selected"
fi
