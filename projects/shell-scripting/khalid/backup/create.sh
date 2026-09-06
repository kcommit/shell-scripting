#!/bin/bash


# learning varible

timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

echo "==============Create a new backup==============="

zip -rq backups/data_backup_"${timestamp}".zip data

