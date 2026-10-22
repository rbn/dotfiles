#!/usr/bin/env bash

SESSION="sketch"
ROOT="$HOME/repos/sketch-tool"
WEB="$ROOT/src/sketch-tool-web"

tmux kill-session -t "$SESSION" 2>/dev/null

LEFT=$(tmux new-session -d -P -F '#{pane_id}' \
    -s "$SESSION" -c "$WEB")

BOTTOM=$(tmux split-window -v -P -F '#{pane_id}' \
    -t "$LEFT" -c "$WEB")

RIGHT=$(tmux split-window -h -P -F '#{pane_id}' \
    -t "$LEFT" -c "$ROOT")

tmux send-keys -t "$LEFT" 'vim .' Enter
tmux send-keys -t "$RIGHT" 'agy' Enter
tmux send-keys -t "$BOTTOM" 'npm run dev' Enter

tmux select-pane -t "$LEFT"

if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION"
else
    tmux attach-session -t "$SESSION"
fi
