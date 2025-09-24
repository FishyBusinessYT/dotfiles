#!/bin/bash

# Configuration Backup Script
# Backs up files and directories specified in backup_list.txt

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_LIST="$SCRIPT_DIR/dirlist.txt"
BACKUP_DIR="$SCRIPT_DIR/backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}


# Create backup directory
mkdir -p "$BACKUP_DIR"

log_info "Starting backup process..."
log_info "Home directory: $HOME"
log_info "Backup directory: $BACKUP_DIR"

# Read backup list and process each entry
while read -r path || [ -n "$path" ]; do
    log_info "Line: $path"

    # Skip empty lines and NOT comments
    [[ -z "$path" || "$path" =~ ^[[:space:]]*# ]] && continue

    source_path="$HOME/$path"
    dest_path="$BACKUP_DIR/$path"

    log_info "Processing: $path"

    if [ -e "$source_path" ]; then
        # Create destination directory
        dest_dir=$(dirname "$dest_path")
        mkdir -p "$dest_dir"

        if [ -d "$source_path" ]; then
            # It's a directory - copy recursively
            if cp -r "$source_path" "$dest_dir/"; then
                log_success "Backed up directory: $path"
            else
                log_error "Failed to backup directory: $path"
            fi
        else
            # It's a file - copy the file
            if cp "$source_path" "$dest_path"; then
                log_success "Backed up file: $path"
            else
                log_error "Failed to backup file: $path"
            fi
        fi
    else
        log_warning "Source not found: $source_path"
    fi
done < "$BACKUP_LIST"

log_success "Backup completed!"
