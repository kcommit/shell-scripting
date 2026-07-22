#!/bin/bash

# This script demonstrates normal output, errors, and exit status.

echo "Running a successful command:"
ls

echo "Exit status is $?"

echo
echo "Running a failing command:"
cd /missing

echo "Exit status is $?"

echo
echo "Saving normal output in standard-output.txt"
ls > standard-output.txt

echo "Saving an error in standard-error.txt"
cd /missing 2> standard-error.txt

echo "Check the two files with cat."
