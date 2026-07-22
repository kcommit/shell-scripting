#!/bin/bash

# Check whether the basket has three fruits

fruit_count="$1"

if [ "$fruit_count" -eq 3 ]
then
    echo "The basket has three fruits"
else
    echo "The basket does not have three fruits"
fi
