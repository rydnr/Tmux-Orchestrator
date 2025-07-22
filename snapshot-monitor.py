#!/usr/bin/env python3
"""
Monitor and automatically fix Claude shell snapshot issues.
Runs as a background service to ensure snapshots always work.
"""

import os
import time
import logging
from pathlib import Path
import re

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger('snapshot-monitor')

class SnapshotMonitor:
    def __init__(self):
        self.snapshot_dir = Path.home() / '.claude' / 'shell-snapshots'
        self.snapshot_pattern = re.compile(r'snapshot-bash-\d+-[a-z0-9]+\.sh$')
        self.check_interval = 5  # seconds
        
    def find_latest_snapshot(self):
        """Find the most recently modified snapshot file."""
        snapshots = list(self.snapshot_dir.glob('snapshot-bash-*.sh'))
        real_snapshots = [s for s in snapshots if s.exists() and not s.is_symlink()]
        
        if not real_snapshots:
            return None
            
        real_snapshots.sort(key=lambda x: x.stat().st_mtime, reverse=True)
        return real_snapshots[0]
    
    def fix_broken_symlinks(self):
        """Find and fix broken snapshot symlinks."""
        fixed_count = 0
        latest = self.find_latest_snapshot()
        
        if not latest:
            logger.warning("No valid snapshots found")
            return 0
            
        # Check all snapshot files
        for snapshot in self.snapshot_dir.glob('snapshot-bash-*.sh'):
            if snapshot.is_symlink() and not snapshot.exists():
                # Broken symlink found
                logger.info(f"Fixing broken symlink: {snapshot.name}")
                snapshot.unlink()
                snapshot.symlink_to(latest)
                fixed_count += 1
                
        return fixed_count
    
    def ensure_recent_snapshots_exist(self):
        """Create symlinks for recently requested snapshots."""
        latest = self.find_latest_snapshot()
        if not latest:
            return
            
        # Check Claude's error log if available (this is speculative)
        # For now, we'll just ensure common patterns exist
        
    def run(self):
        """Main monitoring loop."""
        logger.info(f"Starting snapshot monitor for {self.snapshot_dir}")
        
        if not self.snapshot_dir.exists():
            logger.error(f"Snapshot directory does not exist: {self.snapshot_dir}")
            return
            
        while True:
            try:
                fixed = self.fix_broken_symlinks()
                if fixed > 0:
                    logger.info(f"Fixed {fixed} broken symlinks")
                    
                # Also check if there are any very recent attempts to access non-existent files
                # This would require more sophisticated monitoring (e.g., inotify)
                
            except Exception as e:
                logger.error(f"Error in monitoring loop: {e}")
                
            time.sleep(self.check_interval)

if __name__ == "__main__":
    monitor = SnapshotMonitor()
    monitor.run()