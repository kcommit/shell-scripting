#!/bin/bash

friends=("a" "b" "c")
echo "${friends[@]}"

echo "Happy Birthday: ${friends[2]}"

#friends[2]="d"


friends.append("d")

echo "${friends[@]}"

