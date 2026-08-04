#!/bin/bash

# Topic: For Loop & Arrays
# Purpose: print color list
 
   colors=("Red" "White" "Green" "Blue" "Black" "Yellow")
   color_items=1
   for color in "${colors[@]}"
   do 
	   echo "Color $color_items: $color"
	   color_items=$((color_items + 1))
   done 

   exit 0
