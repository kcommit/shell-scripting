#!/bin/bash

# Task 2 Solution
# Approve dev and test, and require a CHG ticket for production.

if [[ "$#" -ne 2 ]]; then
    echo "Error: exactly two arguments are required." >&2
    echo "Usage: $0 ENVIRONMENT CHANGE_TICKET" >&2
    exit 1
fi

environment="$1"
ticket="$2"

if [[ "$environment" == "dev" ]]; then
    echo "APPROVED: development environment"
    exit 0
elif [[ "$environment" == "test" ]]; then
    echo "APPROVED: testing environment"
    exit 0
elif [[ "$environment" == "prod" && "$ticket" == CHG-* ]]; then
    echo "APPROVED: production environment with ticket $ticket"
    exit 0
elif [[ "$environment" == "prod" ]]; then
    echo "REJECTED: production requires a ticket beginning with CHG-." >&2
    exit 1
else
    echo "REJECTED: invalid environment: $environment" >&2
    echo "Allowed environments: dev, test, prod" >&2
    exit 1
fi

