#!/bin/bash

# Classify student marks
# Enter marks as a whole number.

read -r -p "Enter your marks: " marks

if [ "$marks" -ge 80 ]
then
    echo "Result: Excellent"
elif [ "$marks" -ge 50 ]
then
    echo "Result: Pass"
else
    echo "Result: Keep practising"
fi
