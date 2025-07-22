#!/usr/bin/env bash

# Fix Claude shell snapshot symlink issues automatically
# This script detects missing shell snapshots and creates symlinks to the latest one

SNAPSHOT_DIR="$HOME/.claude/shell-snapshots"

# Function to extract snapshot filename from error message
extract_missing_snapshot() {
    local error_msg="$1"
    echo "$error_msg" | grep -oE "snapshot-bash-[0-9]+-[a-z0-9]+\.sh" | head -1
}

# Function to find the latest snapshot
find_latest_snapshot() {
    ls -t "$SNAPSHOT_DIR"/snapshot-bash-*.sh 2>/dev/null | head -1
}

# Function to create symlink
create_snapshot_symlink() {
    local missing_file="$1"
    local latest_snapshot="$2"
    
    if [ -z "$missing_file" ] || [ -z "$latest_snapshot" ]; then
        echo "Error: Missing required parameters"
        return 1
    fi
    
    # Create symlink
    ln -sf "$latest_snapshot" "$SNAPSHOT_DIR/$missing_file"
    echo "Created symlink: $missing_file -> $(basename "$latest_snapshot")"
}

# Main logic
main() {
    local error_msg="$1"
    
    # Check if snapshot directory exists
    if [ ! -d "$SNAPSHOT_DIR" ]; then
        echo "Error: Snapshot directory not found: $SNAPSHOT_DIR"
        exit 1
    fi
    
    # Extract missing snapshot filename
    local missing_snapshot=$(extract_missing_snapshot "$error_msg")
    
    if [ -z "$missing_snapshot" ]; then
        echo "No snapshot filename found in error message"
        exit 1
    fi
    
    echo "Missing snapshot detected: $missing_snapshot"
    
    # Find latest snapshot
    local latest_snapshot=$(find_latest_snapshot)
    
    if [ -z "$latest_snapshot" ]; then
        echo "Error: No snapshots found in $SNAPSHOT_DIR"
        exit 1
    fi
    
    echo "Latest snapshot found: $(basename "$latest_snapshot")"
    
    # Create symlink
    create_snapshot_symlink "$missing_snapshot" "$latest_snapshot"
}

# Run if called directly with error message
if [ $# -gt 0 ]; then
    main "$*"
else
    echo "Usage: $0 <error message containing missing snapshot>"
    echo "Example: $0 'Error: /run/current-system/sw/bin/bash: line 1: /home/chous/.claude/shell-snapshots/snapshot-bash-1753154555902-vixi0r.sh: No such file or directory'"
fi