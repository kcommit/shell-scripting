#!/bin/bash

# ==========================================================
# Backup Rotation Script
#
# Usage:
#   ./backup_rotation.sh <source> <backup-folder> [number-to-keep]
#
# Examples:
#   ./backup_rotation.sh data backups
#   ./backup_rotation.sh data backups 10
#
# Default:
#   If number-to-keep is not provided, latest 5 backups are kept.
# ==========================================================


# -----------------------------
# Functions
# -----------------------------

function display_usage {
    echo "Usage: $0 <source> <backup-folder> [number-to-keep]"
    echo
    echo "Examples:"
    echo "  $0 data backups"
    echo "  $0 data backups 10"
}


function die {
    echo "Error: $*" >&2
    exit 1
}


# -----------------------------
# Validate Arguments
# -----------------------------

if (( $# < 2 || $# > 3 )); then
    display_usage
    exit 1
fi


# -----------------------------
# Variables
# -----------------------------

source_path="$1"
backup_folder="$2"
keep="${3:-5}"


# -----------------------------
# Validate Source
# -----------------------------

if [[ ! -e "$source_path" ]]; then
    die "Source '$source_path' does not exist."
fi


# -----------------------------
# Validate Retention Value
# -----------------------------

if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
    die "Number-to-keep must be a positive integer."
fi


# -----------------------------
# Check Required Command
# -----------------------------

if ! command -v zip &>/dev/null; then
    echo "Error: zip command is not installed." >&2
    echo
    echo "Ubuntu/Debian:"
    echo "  sudo apt install zip"
    echo
    echo "RHEL/Rocky/AlmaLinux:"
    echo "  sudo dnf install zip"
    exit 1
fi


# -----------------------------
# Create Backup Directory
# -----------------------------

if ! mkdir -p "$backup_folder"; then
    die "Could not create backup folder '$backup_folder'."
fi


# -----------------------------
# Convert Paths to Absolute Paths
# -----------------------------

source_path=$(realpath -- "$source_path") ||
    die "Could not resolve source path."

backup_folder=$(realpath -- "$backup_folder") ||
    die "Could not resolve backup folder."


# -----------------------------
# Prevent Backup Folder Inside Source
# -----------------------------

if [[ -d "$source_path" ]]; then

    if [[ "$backup_folder" == "$source_path" ||
          "$backup_folder" == "$source_path/"* ]]; then

        die "Backup folder must not be inside the source directory."
    fi
fi


# -----------------------------
# Get Source Information
# -----------------------------

source_parent=$(dirname -- "$source_path")
source_name=$(basename -- "$source_path")


# -----------------------------
# Create Timestamped Backup Name
# -----------------------------

timestamp=$(date '+%Y-%m-%d_%H-%M-%S')

backup_file="${backup_folder}/${source_name}_backup_${timestamp}.zip"


# -----------------------------
# Create Backup
# -----------------------------

function create_backup {

    echo
    echo "Creating backup..."
    echo "Source:      $source_path"
    echo "Destination: $backup_file"
    echo

    # Enter the source parent directory so the ZIP archive
    # contains only the source name, not the complete path.
    if (
        cd -- "$source_parent" &&
        zip -rq "$backup_file" "$source_name"
    ); then

        echo "Backup created successfully:"
        echo "$backup_file"

    else

        die "Backup creation failed."
    fi
}


# -----------------------------
# Perform Backup Rotation
# -----------------------------

function perform_rotation {

    local -a backup_records=()
    local -a backups=()
    local -a backups_to_keep=()
    local -a backups_to_remove=()

    local record
    local backup
    local deletion_failed=0


    # Find matching backups and sort newest first.
    #
    # %T@ = modification time
    # %p  = file path
    # \0  = null separator
    #
    mapfile -d '' backup_records < <(
        find "$backup_folder" \
            -maxdepth 1 \
            -type f \
            -name "${source_name}_backup_*.zip" \
            -printf '%T@ %p\0' |
            sort -z -nr
    )


    # Remove the modification-time portion
    # and keep only backup file paths.
    for record in "${backup_records[@]}"; do
        backups+=("${record#* }")
    done


    echo
    echo "Backup Rotation Status"
    echo "----------------------"
    echo "Total backups found: ${#backups[@]}"
    echo "Backups to keep:      $keep"


    # -----------------------------
    # Select Backups to Keep
    # -----------------------------

    backups_to_keep=("${backups[@]:0:$keep}")

    echo
    echo "Newest backups being kept:"

    if (( ${#backups_to_keep[@]} > 0 )); then
        printf '  %s\n' "${backups_to_keep[@]}"
    else
        echo "  None"
    fi


    # -----------------------------
    # Select Old Backups
    # -----------------------------

    backups_to_remove=("${backups[@]:$keep}")


    if (( ${#backups_to_remove[@]} == 0 )); then
        echo
        echo "No old backups need to be deleted."
        return 0
    fi


    echo
    echo "Old backups selected for deletion:"
    printf '  %s\n' "${backups_to_remove[@]}"


    # -----------------------------
    # Delete Old Backups
    # -----------------------------

    echo
    echo "Deleting old backups..."

    for backup in "${backups_to_remove[@]}"; do

        if rm -- "$backup"; then
            echo "Deleted: $backup"
        else
            echo "Error: Could not delete '$backup'." >&2
            deletion_failed=1
        fi

    done


    if (( deletion_failed != 0 )); then
        return 1
    fi

    return 0
}


# ==========================================================
# Main
# ==========================================================

create_backup

if ! perform_rotation; then
    die "Backup was created, but rotation completed with errors."
fi

echo
echo "Backup and rotation completed successfully."
