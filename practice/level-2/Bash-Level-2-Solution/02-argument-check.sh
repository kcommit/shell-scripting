#!/bin/bash

# Validate the number of arguments

if [ "$#" -ne 2 ]
then
    echo "Usage: $0 APPLICATION ENVIRONMENT" >&2
    exit 1
fi

application="$1"
environment="$2"

echo "Application: $application"
echo "Environment: $environment"
exit 0
