#!/usr/bin/env bash

# Setup automatic shell snapshot fixing
# This script provides multiple approaches to handle the snapshot issue

CLAUDE_DIR="$HOME/.claude"
SNAPSHOT_DIR="$CLAUDE_DIR/shell-snapshots"
REAL_SNAPSHOT_DIR="$CLAUDE_DIR/shell-snapshots-real"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up automatic shell snapshot fix..."

# Approach 1: Bash wrapper that intercepts errors
setup_bash_wrapper() {
    echo "Setting up bash wrapper..."
    
    cat > "$CLAUDE_DIR/bash-wrapper.sh" << 'EOF'
#!/bin/bash
# Wrapper that intercepts snapshot errors and fixes them automatically

# Function to fix snapshot
fix_snapshot() {
    local error_msg="$1"
    local missing=$(echo "$error_msg" | grep -oE "snapshot-bash-[0-9]+-[a-z0-9]+\.sh" | head -1)
    if [ -n "$missing" ]; then
        local latest=$(ls -t ~/.claude/shell-snapshots/snapshot-bash-*.sh 2>/dev/null | head -1)
        if [ -n "$latest" ]; then
            ln -sf "$latest" "$HOME/.claude/shell-snapshots/$missing" 2>/dev/null
            echo "[Auto-fixed snapshot: $missing]" >&2
        fi
    fi
}

# Run the actual command
output=$(/bin/bash "$@" 2>&1)
exit_code=$?

# Check for snapshot error
if [[ "$output" == *"No such file or directory"* ]] && [[ "$output" == *"snapshot-bash-"* ]]; then
    fix_snapshot "$output"
    # Retry the command
    output=$(/bin/bash "$@" 2>&1)
    exit_code=$?
fi

# Output the result
echo "$output"
exit $exit_code
EOF
    
    chmod +x "$CLAUDE_DIR/bash-wrapper.sh"
    echo "Bash wrapper created at: $CLAUDE_DIR/bash-wrapper.sh"
}

# Approach 2: Inotify watcher (requires inotify-tools)
setup_inotify_watcher() {
    echo "Setting up inotify watcher..."
    
    cat > "$SCRIPT_DIR/snapshot-watcher.sh" << 'EOF'
#!/bin/bash
# Watch for access to non-existent snapshot files

SNAPSHOT_DIR="$HOME/.claude/shell-snapshots"

# Function to get latest snapshot
get_latest_snapshot() {
    ls -t "$SNAPSHOT_DIR"/snapshot-bash-*.sh 2>/dev/null | head -1
}

# Monitor for failed access attempts
while true; do
    # Check for broken symlinks every 5 seconds
    for link in "$SNAPSHOT_DIR"/snapshot-bash-*.sh; do
        if [ -L "$link" ] && [ ! -e "$link" ]; then
            latest=$(get_latest_snapshot)
            if [ -n "$latest" ]; then
                ln -sf "$latest" "$link"
                echo "[$(date)] Fixed broken symlink: $link -> $latest"
            fi
        fi
    done
    sleep 5
done
EOF
    
    chmod +x "$SCRIPT_DIR/snapshot-watcher.sh"
    echo "Snapshot watcher created at: $SCRIPT_DIR/snapshot-watcher.sh"
}

# Approach 3: LD_PRELOAD interceptor
setup_ld_preload() {
    echo "Setting up LD_PRELOAD interceptor..."
    
    cat > "$SCRIPT_DIR/snapshot-interceptor.c" << 'EOF'
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <time.h>

static int (*real_stat)(const char *path, struct stat *buf) = NULL;
static int (*real_lstat)(const char *path, struct stat *buf) = NULL;
static int (*real_access)(const char *path, int mode) = NULL;
static FILE* (*real_fopen)(const char *path, const char *mode) = NULL;

// Initialize real function pointers
static void init_functions() {
    if (!real_stat) real_stat = dlsym(RTLD_NEXT, "stat");
    if (!real_lstat) real_lstat = dlsym(RTLD_NEXT, "lstat");
    if (!real_access) real_access = dlsym(RTLD_NEXT, "access");
    if (!real_fopen) real_fopen = dlsym(RTLD_NEXT, "fopen");
}

// Check if path is a snapshot file
static int is_snapshot_path(const char *path) {
    return path && strstr(path, "/.claude/shell-snapshots/snapshot-bash-") != NULL;
}

// Find latest snapshot
static char* find_latest_snapshot() {
    static char latest[1024];
    DIR *dir;
    struct dirent *ent;
    char *snapshot_dir = getenv("HOME");
    char full_dir[1024];
    
    snprintf(full_dir, sizeof(full_dir), "%s/.claude/shell-snapshots", snapshot_dir);
    
    dir = opendir(full_dir);
    if (!dir) return NULL;
    
    time_t latest_time = 0;
    latest[0] = '\0';
    
    while ((ent = readdir(dir)) != NULL) {
        if (strstr(ent->d_name, "snapshot-bash-") != NULL) {
            char full_path[1024];
            struct stat st;
            snprintf(full_path, sizeof(full_path), "%s/%s", full_dir, ent->d_name);
            if (real_stat(full_path, &st) == 0 && st.st_mtime > latest_time) {
                latest_time = st.st_mtime;
                strcpy(latest, full_path);
            }
        }
    }
    closedir(dir);
    
    return latest[0] ? latest : NULL;
}

// Intercepted stat
int stat(const char *path, struct stat *buf) {
    init_functions();
    
    if (is_snapshot_path(path)) {
        // Try original first
        int ret = real_stat(path, buf);
        if (ret != 0) {
            // File doesn't exist, try latest snapshot
            char *latest = find_latest_snapshot();
            if (latest) {
                return real_stat(latest, buf);
            }
        }
        return ret;
    }
    
    return real_stat(path, buf);
}

// Similar implementations for lstat, access, fopen...
EOF
    
    echo "LD_PRELOAD interceptor code created (compile with gcc -shared -fPIC)"
}

# Main setup
echo "Which approach would you like to use?"
echo "1. Bash wrapper (simplest)"
echo "2. Inotify watcher (runs in background)"
echo "3. FUSE filesystem (most transparent)"
echo "4. All of the above"

read -p "Enter choice (1-4): " choice

case $choice in
    1) setup_bash_wrapper ;;
    2) setup_inotify_watcher ;;
    3) echo "FUSE setup requires manual intervention. See shell-snapshot-fuse.py" ;;
    4) 
        setup_bash_wrapper
        setup_inotify_watcher
        setup_ld_preload
        ;;
    *) echo "Invalid choice" ;;
esac

echo ""
echo "Setup complete! To use:"
echo "1. Bash wrapper: export BASH=/home/user/.claude/bash-wrapper.sh"
echo "2. Inotify watcher: Run ./snapshot-watcher.sh in background"
echo "3. FUSE: python shell-snapshot-fuse.py /real/dir /mount/point"