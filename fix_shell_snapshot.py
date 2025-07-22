#!/usr/bin/env python3
"""
Fix Claude shell snapshot symlink issues automatically.
This script detects missing shell snapshots and creates symlinks to the latest one.
"""

import os
import sys
import re
from pathlib import Path

def extract_missing_snapshot(error_msg):
    """Extract snapshot filename from error message."""
    pattern = r'snapshot-bash-\d+-[a-z0-9]+\.sh'
    match = re.search(pattern, error_msg)
    return match.group(0) if match else None

def find_latest_snapshot(snapshot_dir):
    """Find the most recently modified snapshot file."""
    snapshot_path = Path(snapshot_dir)
    if not snapshot_path.exists():
        return None
    
    snapshots = list(snapshot_path.glob('snapshot-bash-*.sh'))
    if not snapshots:
        return None
    
    # Sort by modification time, newest first
    snapshots.sort(key=lambda x: x.stat().st_mtime, reverse=True)
    return snapshots[0]

def create_snapshot_symlink(snapshot_dir, missing_file, target_file):
    """Create symlink from missing file to target file."""
    missing_path = Path(snapshot_dir) / missing_file
    
    # Remove existing symlink if it exists
    if missing_path.is_symlink():
        missing_path.unlink()
    
    # Create new symlink
    missing_path.symlink_to(target_file)
    print(f"Created symlink: {missing_file} -> {target_file.name}")

def main():
    """Main function to fix shell snapshot issues."""
    snapshot_dir = os.path.expanduser("~/.claude/shell-snapshots")
    
    # Check if snapshot directory exists
    if not os.path.exists(snapshot_dir):
        print(f"Error: Snapshot directory not found: {snapshot_dir}")
        sys.exit(1)
    
    if len(sys.argv) < 2:
        print("Usage: python fix_shell_snapshot.py '<error message>'")
        print("Example: python fix_shell_snapshot.py 'Error: /home/user/.claude/shell-snapshots/snapshot-bash-123-abc.sh: No such file'")
        sys.exit(1)
    
    error_msg = ' '.join(sys.argv[1:])
    
    # Extract missing snapshot filename
    missing_snapshot = extract_missing_snapshot(error_msg)
    if not missing_snapshot:
        print("No snapshot filename found in error message")
        sys.exit(1)
    
    print(f"Missing snapshot detected: {missing_snapshot}")
    
    # Find latest snapshot
    latest_snapshot = find_latest_snapshot(snapshot_dir)
    if not latest_snapshot:
        print(f"Error: No snapshots found in {snapshot_dir}")
        sys.exit(1)
    
    print(f"Latest snapshot found: {latest_snapshot.name}")
    
    # Create symlink
    try:
        create_snapshot_symlink(snapshot_dir, missing_snapshot, latest_snapshot)
        print("Successfully fixed shell snapshot issue!")
    except Exception as e:
        print(f"Error creating symlink: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()