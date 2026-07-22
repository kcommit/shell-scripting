#!/bin/bash

# Use if, elif, and else

fruit="$1"

if [ "$fruit" = "apple" ]
then
    echo "Apple selected"
elif [ "$fruit" = "banana" ]
then
    echo "Banana selected"
else
    echo "Another fruit selected"
fi
