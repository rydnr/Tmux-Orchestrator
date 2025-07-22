import os
# Quick fix for current snapshot issue
missing = "/home/chous/.claude/shell-snapshots/snapshot-bash-1753109686452-fakiht.sh"
latest = "/home/chous/.claude/shell-snapshots/snapshot-bash-1753154556127-qfkijo.sh"
if os.path.exists(missing):
    os.remove(missing)
os.symlink(latest, missing)
print(f"Fixed! Created symlink: {missing} -> {latest}")