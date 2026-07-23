#!/bin/bash

# Combine arguments with string conditions

name="$1"
role="$2"

echo "Name: $name"

if [ "$role" = "student" ]
then
    echo "Access: Learning area"
elif [ "$role" = "teacher" ]
then
    echo "Access: Teaching area"
else
    echo "Access: Guest area"
fi
