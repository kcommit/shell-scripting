#!/bin/bash

# Task 2 Solution
# Convert positional arguments into descriptive variables.

application="$1"
environment="$2"
version="$3"
artifact="$4"
current_user="$(whoami)"
current_hostname="$(hostname)"
current_date="$(date)"
destination="lab-server/$environment/$application"

echo "Deployment Plan"
echo "---------------"
echo "Application: $application"
echo "Environment: $environment"
echo "Version: $version"
echo "Artifact: $artifact"
echo "Current user: $current_user"
echo "Current hostname: $current_hostname"
echo "Date and time: $current_date"
echo "Destination: $destination"
echo "Planning only: no deployment was performed."

