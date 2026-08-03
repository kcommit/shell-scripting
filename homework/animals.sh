#!/bin/bash

# Topic: For Loop & Arrays.
# Purpose: Print animal list.
  
  animals=("Cow" "Cat" "Goat" "Dog" "Horse")
  animals_items=1

  for animal in "${animals[@]}"
  do 
	  echo "Animal $animals_items: $animal"
	  animals_items=$(($animals_items + 1))
  done

  exit 0
