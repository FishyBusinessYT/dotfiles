#!/bin/bash

# Configuration Restore Script
# Restores files and directories from backup based on backup_list.txt

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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


# Warning and confirmation
log_warning "This will restore backed up files to your home directory!"
log_warning "Existing files ${RED}WILL${NC} be overwritten!"
echo

read -p "Do you want to continue with the restore? y/N: " -n 1 -r response
if [[ ! $response =~ ^[Yy]$ ]]; then
    log_info "Restore cancelled"
    exit 0
fi

exit 0

log_info "Starting restore process..."
log_info "Home directory: $HOME"
log_info "Backup directory: $BACKUP_DIR"


# Simple recursive copy of the entire backup directory structure
if cp -ri "$BACKUP_DIR"/* "$HOME/"; then
    log_success "Restore completed successfully!"
    log_info "You may want to restart your system."
else
    log_error "CP command failed."
fi

