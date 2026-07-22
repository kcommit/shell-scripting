#!/bin/bash

# Classify the basket size

fruit_count="$1"

if [ "$fruit_count" -gt 5 ]
then
    echo "Large basket"
elif [ "$fruit_count" -eq 5 ]
then
    echo "Medium basket"
else
    echo "Small basket"
fi
