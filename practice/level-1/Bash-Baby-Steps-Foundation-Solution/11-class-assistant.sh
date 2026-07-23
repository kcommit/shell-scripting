#!/bin/bash

# Combine arguments, input, command substitution, and conditions

student_name="$1"
homework_file="$2"
today="$(date +%F)"

echo "Student: $student_name"
echo "Date: $today"

read -r -p "Is the student present? Enter yes or no: " attendance

if [ "$attendance" = "yes" ]
then
    echo "Attendance: Present"
else
    echo "Attendance: Absent"
fi

if [ -f "$homework_file" ]
then
    echo "Homework: Found"
else
    echo "Homework: Missing" >&2
fi

echo "Arguments received: $#"
