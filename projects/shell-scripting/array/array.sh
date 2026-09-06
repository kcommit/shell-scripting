#!/bin/bash

# Array learning

items=(apple banana mango orange grapes)

echo "===echo '${items[@]}'====="

echo "${items[@]}"


echo "===echo '${#items[@]}'====="

echo "${#items[@]}"

echo "=======echo '${items[*]}'============

echo "${items[*]}"

echo "=======echo '${items[*]}'===========

echo "${#items[*]}"

echo "==========loop start============"


for i in "${items[@]}";
do 
	echo "$i"
done

echo

echo "===================="

printf '%s\n' "${items[@]}"

echo "======================"
