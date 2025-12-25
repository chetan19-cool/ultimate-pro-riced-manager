#!/bin/bash
source ../utils/colors.sh
source ../utils/ask_yes_no.sh

BACKUP_DIR=~/.riced-backups

if [ ! -d "$BACKUP_DIR" ]; then
    warn "No backups found."
    exit 0
fi

echo "Available backups:"
ls -1 "$BACKUP_DIR"
read -p "Enter backup folder to restore: " BACKUP_NAME
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

if [ ! -d "$BACKUP_PATH" ]; then
    error "Backup folder not found."
    exit 1
fi

if ask_yes_no "Are you sure you want to restore this backup? Existing configs will be overwritten." "N"; then
    cp -r "$BACKUP_PATH/"* ~/
    log "Backup restored successfully from $BACKUP_PATH"
else
    log "Restore canceled."
fi
