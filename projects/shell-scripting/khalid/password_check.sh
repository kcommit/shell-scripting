#!/bin/bash

# Title: Password Authentication Loop
# Description: Prompt user for password until correct input is given.

echo "=============================="
echo "    PASSWORD AUTHENTICATION    "
echo "=============================="

user_input=""

while [ "$user_input" != "secret123" ]
do
    read -sp "Enter your password: " user_input
    echo ""
done

echo "Access granted"
