#!/bin/bash

# Task 5 Solution
# Copy a validated artifact to a safe local deployment directory.

if [[ "$#" -ne 4 ]]; then
    echo "Error: exactly four arguments are required." >&2
    echo "Usage: $0 APPLICATION ENVIRONMENT VERSION ARTIFACT" >&2
    exit 1
fi

application="$1"
environment="$2"
version="$3"
artifact="$4"

if [[ -z "$application" || -z "$environment" || -z "$version" || -z "$artifact" ]]; then
    echo "Deployment failed: arguments cannot be empty." >&2
    exit 1
elif [[ "$application" == */* || "$version" == */* ]]; then
    echo "Deployment failed: application and version cannot contain a slash." >&2
    exit 1
elif [[ "$environment" != "dev" && "$environment" != "test" && "$environment" != "prod" ]]; then
    echo "Deployment failed: invalid environment: $environment" >&2
    exit 1
elif [[ ! -f "$artifact" ]]; then
    echo "Deployment failed: artifact does not exist: $artifact" >&2
    exit 1
elif [[ ! -s "$artifact" ]]; then
    echo "Deployment failed: artifact is empty: $artifact" >&2
    exit 1
fi

destination="lab-server/$environment/$application/$version"

if mkdir -p "$destination"; then
    echo "Destination created: $destination"
else
    echo "Deployment failed: could not create destination." >&2
    exit 1
fi

if cp "$artifact" "$destination/"; then
    echo "Artifact copied to: $destination/$(basename "$artifact")"
    echo "Deployment successful: $application $version to $environment"
    exit 0
else
    echo "Deployment failed: could not copy the artifact." >&2
    exit 1
fi

