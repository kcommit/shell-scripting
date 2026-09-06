#!/bin/bash

# Func-variable

name="Global"

change_name()
{
	local name="Local"
	echo "Inside: $name"
}

change_name
echo "$name"
