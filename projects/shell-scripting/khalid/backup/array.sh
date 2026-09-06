#!/bin/bash

# learning ARRAY


items=(apple banana mango orange grapes)


echo "============Loop starts from here"


for i in "${items[@]}";
do
	echo "$i"
done

echo "===================printf=============="

printf '%s\n' "${items[@]}"


echo "-----------printf END------------------"


printf '%s\n' "${items[@]:1:3}"


echo "-----------printf  will print upto End------------------"


printf '%s\n' "${items[@]:1}"


