#!/bin/bash

echo "=== Backup Utility ==="

read -rp "Enter source directory: " SOURCE
read -rp "Enter backup destination: " BACKUP_DIR

# Validate source
if [[ ! -d "$SOURCE" ]]; then
    echo "ERROR: Source directory does not exist."
    exit 1
fi

# Create destination if needed
mkdir -p "$BACKUP_DIR"

DATE=$(date +%Y%m%d_%H%M%S)

# Extract source folder name
DIR_NAME=$(basename "$SOURCE")

BACKUP_FILE="${BACKUP_DIR}/${DIR_NAME}_backup_${DATE}.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE"

if [[ $? -eq 0 ]]; then
    echo "Backup completed successfully."
    echo "Backup file: $BACKUP_FILE"
else
    echo "Backup failed."
fi