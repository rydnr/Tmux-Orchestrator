#!/usr/bin/env bash

# Enhanced message sender that detects if Claude is running and restarts if needed
# Usage: send-claude-message-safe.sh <session:window> <message>

if [ $# -lt 2 ]; then
    echo "Usage: $0 <session:window> <message>"
    echo "Example: $0 agentic-seek:3 'Hello Claude!'"
    exit 1
fi

WINDOW="$1"
shift # Remove first argument, rest is the message
MESSAGE="$*"

# Function to check if Claude is running in the window
is_claude_running() {
    local window="$1"
    local output=$(tmux capture-pane -t "$window" -p -S -30 2>/dev/null | tail -30)
    
    # Check for various Claude indicators
    if [[ "$output" == *"Bypassing Permissions"* ]] || \
       [[ "$output" == *"Baking…"* ]] || \
       [[ "$output" == *"Discombobulating…"* ]] || \
       [[ "$output" == *"? for shortcuts"* ]] || \
       [[ "$output" == *"claude.ai/code"* ]] || \
       [[ "$output" == *"Press up to edit queued messages"* ]]; then
        return 0  # Claude is running
    else
        return 1  # Claude is not running
    fi
}

# Function to check if window is at shell prompt
is_at_shell_prompt() {
    local window="$1"
    local output=$(tmux capture-pane -t "$window" -p -S -5 2>/dev/null | tail -5)
    
    # Common shell prompt patterns
    if [[ "$output" == *"$"* ]] || \
       [[ "$output" == *"#"* ]] || \
       [[ "$output" == *"❯"* ]] || \
       [[ "$output" == *">"* ]] || \
       [[ "$output" == *"bash"* ]] || \
       [[ "$output" == *"zsh"* ]]; then
        return 0
    else
        return 1
    fi
}

# Function to start Claude
start_claude() {
    local window="$1"
    echo "Claude not detected in $window, starting Claude..."
    
    # Send command to start Claude
    tmux send-keys -t "$window" "~/bin/claude" Enter
    
    # Wait for Claude to start (check for up to 10 seconds)
    local count=0
    while [ $count -lt 20 ]; do
        sleep 0.5
        if is_claude_running "$window"; then
            echo "Claude started successfully in $window"
            return 0
        fi
        ((count++))
    done
    
    echo "Warning: Claude may not have started properly in $window"
    return 1
}

# Main logic
echo "Checking if Claude is running in $WINDOW..."

if ! is_claude_running "$WINDOW"; then
    echo "Claude not detected in $WINDOW"
    
    # Check if we're at a shell prompt
    if is_at_shell_prompt "$WINDOW"; then
        # Try to start Claude
        if start_claude "$WINDOW"; then
            # Give Claude a moment to fully initialize
            sleep 2
        else
            echo "Failed to start Claude, sending message anyway..."
        fi
    else
        echo "Warning: Window doesn't appear to be at a shell prompt"
        echo "Current window content:"
        tmux capture-pane -t "$WINDOW" -p -S -10 | tail -10
        echo "---"
        echo "Attempting to send message anyway..."
    fi
else
    echo "Claude is running in $WINDOW"
fi

# Send the message
echo "Sending message to $WINDOW: $MESSAGE"
tmux send-keys -t "$WINDOW" "$MESSAGE"

# Wait 0.5 seconds for UI to register
sleep 0.5

# Send Enter to submit
tmux send-keys -t "$WINDOW" Enter

echo "Message sent!"