#!/bin/bash
# Add this to your .bashrc or .zshrc to automatically fix Claude snapshot issues

# Function to fix Claude shell snapshots
claude_fix_snapshot() {
    local snapshot_dir="$HOME/.claude/shell-snapshots"
    local latest=$(ls -t "$snapshot_dir"/snapshot-bash-*.sh 2>/dev/null | grep -v '@' | head -1)
    
    if [ -z "$latest" ]; then
        echo "No valid snapshots found in $snapshot_dir"
        return 1
    fi
    
    # Fix all broken symlinks
    local fixed=0
    for link in "$snapshot_dir"/snapshot-bash-*.sh; do
        if [ -L "$link" ] && [ ! -e "$link" ]; then
            rm -f "$link"
            ln -s "$latest" "$link"
            echo "Fixed: $(basename "$link") -> $(basename "$latest")"
            ((fixed++))
        fi
    done
    
    if [ $fixed -eq 0 ]; then
        echo "No broken snapshots found"
    else
        echo "Fixed $fixed broken snapshot(s)"
    fi
}

# Bash command not found handler that fixes snapshots
command_not_found_handler() {
    # Check if this is a snapshot error
    if [[ "$1" == *"/.claude/shell-snapshots/snapshot-bash-"* ]]; then
        echo "Detected Claude snapshot error, attempting to fix..."
        claude_fix_snapshot
        return 127
    fi
    
    # Default behavior
    echo "bash: $1: command not found"
    return 127
}

# For Zsh users
command_not_found_handler() {
    # Check if this is a snapshot error  
    if [[ "$1" == *"/.claude/shell-snapshots/snapshot-bash-"* ]]; then
        echo "Detected Claude snapshot error, attempting to fix..."
        claude_fix_snapshot
        return 127
    fi
    
    # Default behavior
    echo "zsh: command not found: $1"
    return 127
}

# Auto-fix on shell startup
if [ -d "$HOME/.claude/shell-snapshots" ]; then
    # Silently fix any broken snapshots on startup
    claude_fix_snapshot >/dev/null 2>&1
fi

# Alias for manual fixing
alias fix-claude="claude_fix_snapshot"

echo "Claude snapshot auto-fix loaded. Use 'fix-claude' to manually fix snapshots."