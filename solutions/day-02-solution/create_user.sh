#!/bin/bash

# This is a basic user creation script.
# Run it only on WSL or a Linux practice machine.

echo "Enter username:"
read username

echo "Checking whether $username already exists"

getent passwd "$username" >/dev/null || sudo useradd -m "$username"

getent passwd "$username" >/dev/null && echo "User is ready: $username" || echo "User could not be created: $username"

echo
echo "User identity:"
id "$username"

echo
echo "User entry:"
getent passwd "$username"
