#!/bin/bash

# Task 1 Solution
# Classify CPU and disk usage with traditional single brackets.

if [ "$#" -ne 2 ]; then
    echo "Error: exactly two arguments are required." >&2
    echo "Usage: $0 CPU_USAGE DISK_USAGE" >&2
    exit 1
fi

cpu_usage="$1"
disk_usage="$2"

if [ "$cpu_usage" -lt 0 ] || [ "$cpu_usage" -gt 100 ] || [ "$disk_usage" -lt 0 ] || [ "$disk_usage" -gt 100 ]; then
    echo "INVALID: CPU and disk usage must be between 0 and 100." >&2
    exit 1
elif [ "$cpu_usage" -ge 90 ] || [ "$disk_usage" -ge 90 ]; then
    echo "CRITICAL: CPU=$cpu_usage% Disk=$disk_usage%"
    exit 3
elif [ "$cpu_usage" -ge 70 ] || [ "$disk_usage" -ge 70 ]; then
    echo "WARNING: CPU=$cpu_usage% Disk=$disk_usage%"
    exit 2
else
    echo "HEALTHY: CPU=$cpu_usage% Disk=$disk_usage%"
    exit 0
fi

