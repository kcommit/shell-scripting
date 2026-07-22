#!/bin/bash

# This script demonstrates && and ||.

echo "Example of &&"
echo "The second command runs when the first command succeeds."

mkdir -p d1 && cd d1

echo "Current directory is $PWD"

cd ..

echo
echo "Example of ||"
echo "The second command runs when the first command fails."

cd /missing || cd d1

echo "Current directory is $PWD"
