#!/usr/bin/env bash

# Claude health check and restart utility
# Can be used standalone or sourced by other scripts

# Function to check if Claude is running in a window
check_claude_health() {
    local window="$1"
    local output=$(tmux capture-pane -t "$window" -p -S -30 2>/dev/null | tail -30)
    
    # Return codes:
    # 0 = Claude is running
    # 1 = Claude not running, at shell prompt
    # 2 = Claude not running, unknown state
    # 3 = Window doesn't exist
    
    # Check if window exists
    if ! tmux list-panes -t "$window" &>/dev/null; then
        return 3
    fi
    
    # Check for Claude indicators
    if [[ "$output" == *"Bypassing Permissions"* ]] || \
       [[ "$output" == *"Baking…"* ]] || \
       [[ "$output" == *"Discombobulating…"* ]] || \
       [[ "$output" == *"? for shortcuts"* ]] || \
       [[ "$output" == *"claude.ai/code"* ]] || \
       [[ "$output" == *"Press up to edit queued messages"* ]] || \
       [[ "$output" == *"Thinking…"* ]] || \
       [[ "$output" == *"Refactoring…"* ]]; then
        return 0  # Claude is running
    fi
    
    # Check if at shell prompt
    if [[ "$output" == *"$"* ]] || \
       [[ "$output" == *"#"* ]] || \
       [[ "$output" == *"❯"* ]] || \
       [[ "$output" == *"bash"* ]] || \
       [[ "$output" == *"zsh"* ]]; then
        return 1  # At shell prompt
    fi
    
    return 2  # Unknown state
}

# Function to restart Claude
restart_claude() {
    local window="$1"
    
    echo "[Claude Health Check] Restarting Claude in $window..."
    
    # Send Ctrl+C to interrupt any running command
    tmux send-keys -t "$window" C-c
    sleep 0.5
    
    # Clear the line
    tmux send-keys -t "$window" C-u
    sleep 0.2
    
    # Start Claude
    tmux send-keys -t "$window" "~/bin/claude" Enter
    
    # Wait for Claude to start
    local count=0
    while [ $count -lt 20 ]; do
        sleep 0.5
        check_claude_health "$window"
        if [ $? -eq 0 ]; then
            echo "[Claude Health Check] Claude restarted successfully"
            return 0
        fi
        ((count++))
    done
    
    echo "[Claude Health Check] Warning: Claude may not have started properly"
    return 1
}

# Function to ensure Claude is running
ensure_claude_running() {
    local window="$1"
    
    check_claude_health "$window"
    local status=$?
    
    case $status in
        0)
            echo "[Claude Health Check] Claude is healthy in $window"
            return 0
            ;;
        1)
            echo "[Claude Health Check] Claude not running, restarting..."
            restart_claude "$window"
            return $?
            ;;
        2)
            echo "[Claude Health Check] Window in unknown state, attempting restart..."
            restart_claude "$window"
            return $?
            ;;
        3)
            echo "[Claude Health Check] Error: Window $window doesn't exist"
            return 1
            ;;
    esac
}

# If run directly (not sourced)
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ $# -lt 1 ]; then
        echo "Usage: $0 <session:window>"
        echo "Example: $0 backend1:0"
        exit 1
    fi
    
    ensure_claude_running "$1"
fi