#!/bin/bash

# conditional Traffic Light

echo

echo " Example-2: Traffic Light"

read -r -p "Enter traffic-light color (red/yellow/green): " light

echo

if [[ "$light" = "red" ]]; then
	
	echo
	echo "Stop!!"

elif [[ "$light" = "yellow" ]]; then

	echo
	echo "get ready"

elif [[ "$light" = "green" ]]; then

	echo
	echo "Go Go Go"
else 
	echo
	echo "Move on your risk!!!!!!"
fi


