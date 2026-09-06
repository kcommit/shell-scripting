#!/bin/bash

# daily life conditions

echo

echo "Example: Weather Decision"

read -r -p "Is it raining? Enter yes or no: " weather

if [[ "$weather" = "yes" ]]; then

   echo "Take an umbrella"

else
 
   echo "You do not need umbrella"

fi
 
