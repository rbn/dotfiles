#!/usr/bin/env bash

# Start from the top-left pane.
tmux select-pane -t '{top-left}'

# Make the upper-right pane columns wide.
tmux select-pane -R
tmux resize-pane -x 60 

# Return to upper-left.
tmux select-pane -L

# Move to bottom.
tmux select-pane -D

# Make bottom pane rows tall.
tmux resize-pane -y 20 
 
# Restore focus to Neovim in upper-left.
tmux select-pane -t '{top-left}'
