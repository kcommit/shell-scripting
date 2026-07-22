#!/bin/bash

# Task 5 Solution
# Run every conditional readiness gate before deployment.

if [[ "$#" -ne 6 ]]; then
    echo "Error: exactly six arguments are required." >&2
    echo "Usage: $0 APPLICATION ENVIRONMENT CHANGE_TICKET ARTIFACT CPU_USAGE DISK_USAGE" >&2
    exit 1
fi

application="$1"
environment="$2"
ticket="$3"
artifact="$4"
cpu_usage="$5"
disk_usage="$6"

if [[ -z "$application" ]]; then
    echo "Readiness failed: application name is empty." >&2
    exit 1
elif [[ "$application" == */* ]]; then
    echo "Readiness failed: application name cannot contain a slash." >&2
    exit 1
fi

echo "Running resource gate..."

if ./01-resource-check.sh "$cpu_usage" "$disk_usage"; then
    echo "Resource gate passed."
else
    echo "RELEASE NOT READY: resource gate failed." >&2
    exit 1
fi

echo "Running environment gate..."

if ./02-environment-gate.sh "$environment" "$ticket"; then
    echo "Environment gate passed."
else
    echo "RELEASE NOT READY: environment gate failed." >&2
    exit 1
fi

echo "Running artifact preflight..."

if ./03-artifact-preflight.sh "$artifact"; then
    echo "Artifact gate passed."
else
    echo "RELEASE NOT READY: artifact gate failed." >&2
    exit 1
fi

echo "Checking required deployment tool..."

if ./04-tool-health-check.sh tar; then
    echo "Tool gate passed."
else
    echo "RELEASE NOT READY: required tool gate failed." >&2
    exit 1
fi

echo "RELEASE READY: $application can be deployed to $environment."
exit 0

