#!/bin/bash

# Funcs Arguments

show_items()
{
echo "Arguments count: $#"

for item in "$@"
do
	echo "item: $item"
done

}

show_items "apple" "banana" "red cherry"
