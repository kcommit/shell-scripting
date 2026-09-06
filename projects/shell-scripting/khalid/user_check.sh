#!/bin/bash
#
#Check user existance
#
if id $1 &> /dev/null; then
    echo "user: $1 exists"
else 
    echo "user: $1 does not exists"
fi
exit 0
