#!/bin/bash

# Task 6 Solution
# Deploy only an approved release and write an audit record.

mkdir -p logs
log_file="logs/deployment-audit.log"
timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
current_user="$(whoami)"

if [[ "$#" -ne 6 ]]; then
    echo "Error: exactly six arguments are required." >&2
    echo "Usage: $0 APPLICATION ENVIRONMENT CHANGE_TICKET ARTIFACT CPU_USAGE DISK_USAGE" >&2
    echo "$timestamp | User=$current_user | Application=$1 | Environment=$2 | Ticket=$3 | Artifact=$4 | CPU=$5 | Disk=$6 | Status=FAILED_ARGUMENT_COUNT" >> "$log_file"
    exit 1
fi

application="$1"
environment="$2"
ticket="$3"
artifact="$4"
cpu_usage="$5"
disk_usage="$6"

echo "Starting conditional deployment controller"
echo "Application: $application"
echo "Environment: $environment"
echo "Change ticket: $ticket"
echo "Artifact: $artifact"
echo "CPU usage: $cpu_usage%"
echo "Disk usage: $disk_usage%"

if ./05-release-readiness.sh "$application" "$environment" "$ticket" "$artifact" "$cpu_usage" "$disk_usage"; then
    echo "All readiness gates passed."
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Ticket=$ticket | Artifact=$artifact | CPU=$cpu_usage | Disk=$disk_usage | Status=FAILED_READINESS" >> "$log_file"
    echo "Deployment stopped: release readiness failed." >&2
    exit 1
fi

destination="lab-server/$environment/$application"

if mkdir -p "$destination"; then
    echo "Destination created: $destination"
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Ticket=$ticket | Artifact=$artifact | CPU=$cpu_usage | Disk=$disk_usage | Status=FAILED_DIRECTORY_CREATION" >> "$log_file"
    echo "Deployment failed: could not create destination." >&2
    exit 1
fi

if cp "$artifact" "$destination/"; then
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Ticket=$ticket | Artifact=$artifact | CPU=$cpu_usage | Disk=$disk_usage | Status=SUCCESS" >> "$log_file"
    echo "Artifact copied to: $destination/$(basename "$artifact")"
    echo "DEPLOYMENT SUCCESSFUL: $application to $environment"
    exit 0
else
    echo "$timestamp | User=$current_user | Application=$application | Environment=$environment | Ticket=$ticket | Artifact=$artifact | CPU=$cpu_usage | Disk=$disk_usage | Status=FAILED_COPY" >> "$log_file"
    echo "Deployment failed: artifact could not be copied." >&2
    exit 1
fi

