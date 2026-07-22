#!/bin/bash

# Task 3 Solution
# Validate the argument count and deployment environment.

if [[ "$#" -ne 4 ]]; then
    echo "Error: exactly four arguments are required." >&2
    echo "Usage: $0 APPLICATION ENVIRONMENT VERSION ARTIFACT" >&2
    exit 1
fi

environment="$2"

if [[ "$environment" == "dev" ]]; then
    echo "Request approved for the dev environment."
elif [[ "$environment" == "test" ]]; then
    echo "Request approved for the test environment."
elif [[ "$environment" == "prod" ]]; then
    echo "Request approved for the prod environment."
else
    echo "Error: invalid environment: $environment" >&2
    echo "Allowed environments: dev, test, prod" >&2
    exit 1
fi

exit 0

