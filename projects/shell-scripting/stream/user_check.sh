#!/bin/bash
#


if id $1 &> /dev/null; then
    echo "$1 user exist"
else
    echo "$1 does not exit"
fi
