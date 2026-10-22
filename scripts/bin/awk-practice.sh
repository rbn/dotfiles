#!/usr/bin/env bash

SESSION="practice"

# Replace these with your desired files
FILE1="$HOME/awk-practice.txt"
FILE2="$HOME/awk-challenges.txt"

# If the session exists, attach to it
if tmux has-session -t "=$SESSION" 2>/dev/null; then
    exec tmux attach-session -t "=$SESSION"
fi

# Create a detached session
tmux new-session -d -s "$SESSION" -n workspace

# Split into left and right panes
tmux split-window -h -t "$SESSION:0.0"

# Split the left pane horizontally (top and bottom)
tmux split-window -v -t "$SESSION:0.0"

# Open Neovim in the two left panes
tmux send-keys -t "$SESSION:0.0" "nvim '$FILE1'" Enter
tmux send-keys -t "$SESSION:0.2" "nvim '$FILE2'" Enter

# Put the cursor in the right terminal
tmux select-pane -t "$SESSION:0.1"

# Attach
exec tmux attach-session -t "=$SESSION"
