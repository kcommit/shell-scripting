#!/bin/bash

# Topic: For Loop & Arrays.
# Purpose: Print Subjects List.
  
   subjects=("Math" "Com" "Eng" "Arabic" "Physics" "Bio" "Chem")
   subject_items=1

   for subject in "${subjects[@]}"
   do 
	   echo "Subject $subject_items: $subject"
	   subject_items=$((subject_items + 1))
   done

   exit 0
