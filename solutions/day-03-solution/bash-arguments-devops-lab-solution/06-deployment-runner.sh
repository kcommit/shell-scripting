#!/bin/bash

# Task 6 Solution
# Run validation, preflight, deployment, and audit logging.

mkdir -p logs
log_file="logs/deployment.log"
timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
current_user="$(whoami)"

if [[ "$#" -ne 4 ]]; then
    echo "Error: exactly four arguments are required." >&2
    echo "Usage: $0 APPLICATION ENVIRONMENT VERSION ARTIFACT" >&2
    echo "$timestamp | User=$current_user | Application=${1:-missing} | Environment=${2:-missing} | Version=${3:-missing} | Artifact=${4:-missing} | Status=FAILED_ARGUMENT_COUNT" >> "$log_file"
    exit 1
fi

application="$1"
environment="$2"
version="$3"
artifact="$4"

echo "Starting deployment workflow"
echo "Application: $application"
echo "Environment: $environment"
echo "Version: $version"
echo "Artifact: $artifact"

if ./03-validate-request.sh "$@"; then
    echo "Request validation completed."
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Version=$version | Artifact=$artifact | Status=FAILED_VALIDATION" >> "$log_file"
    echo "Deployment workflow failed during request validation." >&2
    exit 1
fi

if ./04-artifact-preflight.sh "$artifact"; then
    echo "Artifact preflight completed."
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Version=$version | Artifact=$artifact | Status=FAILED_PREFLIGHT" >> "$log_file"
    echo "Deployment workflow failed during artifact preflight." >&2
    exit 1
fi

if ./05-local-deploy.sh "$@"; then
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Version=$version | Artifact=$artifact | Status=SUCCESS" >> "$log_file"
    echo "Deployment workflow completed successfully."
    exit 0
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Version=$version | Artifact=$artifact | Status=FAILED_DEPLOYMENT" >> "$log_file"
    echo "Deployment workflow failed during local deployment." >&2
    exit 1
fi

