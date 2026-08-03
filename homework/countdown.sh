#!/bin/bash
 
# Title: Countdown
# Purpose: counting useradding  whole NO Down to Zero.
 if ! read -r -p "Enter a starting number: " starting_number; then
	 echo "Error: could not read the input." >&2
	 exit 1
 fi 

 if [[ ! "$starting_number" =~ ^[0-9]+$ ]]; then 
	 echo "Error: enter a non-negative whole number." >&2 
	 exit 1
 fi
 count=$((10#$starting_number))

 while (( count >= 0 ))
 do 
	 echo "$count"
	 count=$((count - 1))
 done

 echo "Done!"
 exit 0
