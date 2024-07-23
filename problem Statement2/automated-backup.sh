#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIRECTORY=$1

if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory $DIRECTORY does not exist."
    exit 1
fi

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"
S3_BUCKET="hritik123"

tar -czf /tmp/$BACKUP_FILE -C "$DIRECTORY" .

if [ $? -ne 0 ]; then
    echo "Error: Failed to create backup file."
    exit 1
fi

aws s3 cp /tmp/$BACKUP_FILE s3://$S3_BUCKET/

# Check if aws s3 cp command was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE has been uploaded to s3://$S3_BUCKET/"
    # Cleanup the local backup file
    rm /tmp/$BACKUP_FILE
else
    echo "Error: Failed to upload backup file to S3."
    exit 1
fi
