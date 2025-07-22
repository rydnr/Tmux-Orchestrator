#!/usr/bin/env python3
"""
FUSE filesystem for Claude shell snapshots that automatically redirects
missing snapshot files to the latest available snapshot.

This creates a virtual filesystem that intercepts file access and prevents
"file not found" errors for snapshot files.

Requirements:
    pip install fusepy

Usage:
    python shell-snapshot-fuse.py /path/to/real/snapshots /path/to/mount/point
"""

import os
import sys
import errno
import logging
from pathlib import Path
import re

try:
    from fuse import FUSE, FuseOSError, Operations
except ImportError:
    print("Error: fusepy not installed. Run: pip install fusepy")
    sys.exit(1)

class SnapshotFS(Operations):
    def __init__(self, root):
        self.root = root
        self.snapshot_pattern = re.compile(r'snapshot-bash-\d+-[a-z0-9]+\.sh$')
        logging.info(f"SnapshotFS initialized with root: {root}")
    
    def _full_path(self, partial):
        """Get full path, handling snapshot redirects."""
        if partial.startswith("/"):
            partial = partial[1:]
        
        path = os.path.join(self.root, partial)
        
        # Check if this is a snapshot file that doesn't exist
        if (self.snapshot_pattern.search(partial) and 
            not os.path.exists(path)):
            # Find the latest snapshot
            latest = self._find_latest_snapshot()
            if latest:
                logging.info(f"Redirecting {partial} to {latest}")
                return latest
        
        return path
    
    def _find_latest_snapshot(self):
        """Find the most recent snapshot file."""
        try:
            snapshots = list(Path(self.root).glob('snapshot-bash-*.sh'))
            if snapshots:
                snapshots.sort(key=lambda x: x.stat().st_mtime, reverse=True)
                return str(snapshots[0])
        except Exception as e:
            logging.error(f"Error finding latest snapshot: {e}")
        return None
    
    def access(self, path, mode):
        full_path = self._full_path(path)
        if not os.access(full_path, mode):
            raise FuseOSError(errno.EACCES)
    
    def chmod(self, path, mode):
        full_path = self._full_path(path)
        return os.chmod(full_path, mode)
    
    def chown(self, path, uid, gid):
        full_path = self._full_path(path)
        return os.chown(full_path, uid, gid)
    
    def getattr(self, path, fh=None):
        full_path = self._full_path(path)
        st = os.lstat(full_path)
        return dict((key, getattr(st, key)) for key in ('st_atime', 'st_ctime',
                     'st_gid', 'st_mode', 'st_mtime', 'st_nlink', 'st_size', 'st_uid'))
    
    def readdir(self, path, fh):
        full_path = self._full_path(path)
        dirents = ['.', '..']
        if os.path.isdir(full_path):
            dirents.extend(os.listdir(full_path))
        for r in dirents:
            yield r
    
    def readlink(self, path):
        pathname = os.readlink(self._full_path(path))
        if pathname.startswith("/"):
            return os.path.relpath(pathname, self.root)
        else:
            return pathname
    
    def mknod(self, path, mode, dev):
        return os.mknod(self._full_path(path), mode, dev)
    
    def rmdir(self, path):
        full_path = self._full_path(path)
        return os.rmdir(full_path)
    
    def mkdir(self, path, mode):
        return os.mkdir(self._full_path(path), mode)
    
    def statfs(self, path):
        full_path = self._full_path(path)
        stv = os.statvfs(full_path)
        return dict((key, getattr(stv, key)) for key in ('f_bavail', 'f_bfree',
            'f_blocks', 'f_bsize', 'f_favail', 'f_ffree', 'f_files', 'f_flag',
            'f_frsize', 'f_namemax'))
    
    def unlink(self, path):
        return os.unlink(self._full_path(path))
    
    def symlink(self, name, target):
        return os.symlink(target, self._full_path(name))
    
    def rename(self, old, new):
        return os.rename(self._full_path(old), self._full_path(new))
    
    def link(self, target, name):
        return os.link(self._full_path(target), self._full_path(name))
    
    def utimens(self, path, times=None):
        return os.utime(self._full_path(path), times)
    
    def open(self, path, flags):
        full_path = self._full_path(path)
        return os.open(full_path, flags)
    
    def create(self, path, mode, fi=None):
        full_path = self._full_path(path)
        return os.open(full_path, os.O_WRONLY | os.O_CREAT, mode)
    
    def read(self, path, length, offset, fh):
        os.lseek(fh, offset, os.SEEK_SET)
        return os.read(fh, length)
    
    def write(self, path, buf, offset, fh):
        os.lseek(fh, offset, os.SEEK_SET)
        return os.write(fh, buf)
    
    def truncate(self, path, length, fh=None):
        full_path = self._full_path(path)
        with open(full_path, 'r+') as f:
            f.truncate(length)
    
    def flush(self, path, fh):
        return os.fsync(fh)
    
    def release(self, path, fh):
        return os.close(fh)
    
    def fsync(self, path, fdatasync, fh):
        return self.flush(path, fh)

def main():
    if len(sys.argv) != 3:
        print("Usage: %s <real_snapshots_dir> <mount_point>" % sys.argv[0])
        sys.exit(1)
    
    real_dir = sys.argv[1]
    mount_point = sys.argv[2]
    
    # Setup logging
    logging.basicConfig(level=logging.INFO)
    
    # Create mount point if it doesn't exist
    os.makedirs(mount_point, exist_ok=True)
    
    FUSE(SnapshotFS(real_dir), mount_point, nothreads=True, foreground=True)

if __name__ == '__main__':
    main()