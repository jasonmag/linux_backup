#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_directory> <backup_directory>"
    exit 1
fi

# Set the variables from input arguments
PROJECT_DIR="$1"
BACKUP_DIR="$2"

# Extract the project directory name from the full path
PROJECT_NAME=$(basename "$PROJECT_DIR")
ARCHIVE_NAME="${PROJECT_NAME}_$(date +%Y%m%d).tar.gz"
ARCHIVE_PATH="/tmp/$ARCHIVE_NAME"

# Create a tarball and compress it with gzip
tar -czvf $ARCHIVE_PATH -C $(dirname $PROJECT_DIR) $PROJECT_NAME

# Check if the tar command was successful
if [ $? -ne 0 ]; then
    echo "Failed to create the archive."
    exit 1
fi

# Copy the archive to the backup directory on the hard drive
cp $ARCHIVE_PATH $BACKUP_DIR

# Check if the copy command was successful
if [ $? -ne 0 ]; then
    echo "Failed to copy the archive to the backup directory."
    exit 1
fi

# Optionally, remove the archive from /tmp after copying
rm $ARCHIVE_PATH

# Output a message indicating the backup was successful
echo "Backup of $PROJECT_DIR completed and saved to $BACKUP_DIR/$ARCHIVE_NAME"

