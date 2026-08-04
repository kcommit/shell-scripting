#!/bin/bash

#Title: Greeting Script
#Purpose: greeting username as first argument.

if [[ "$#" -lt 1 ]]; then
       	echo "Usage: $0 NAME" >&2
	exit 1
fi

name="$1" 

echo "Hello, $name!"
exit 0
