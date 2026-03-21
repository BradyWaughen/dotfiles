#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# tmux-session.sh — Claude Code workflow layout
#
#  ┌─────────────┬──────────────────────────────────┐
#  │             │                                  │
#  │    admin    │         claude code              │
#  │   (prompt   │         (main worker)            │
#  │   writer)   │                                  │
#  │             ├─────────────────┬────────────────┤
#  │             │   monitor 1     │   monitor 2    │
#  └─────────────┴─────────────────┴────────────────┘
# ─────────────────────────────────────────────────────────────────────────────

START_DIR="${1:-$(pwd)}"
SESSION="claude-$(basename "$START_DIR")"

if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already running. Attach with: tmux attach -t $SESSION"
    exit 0
fi

cd "$START_DIR"

tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)" -c "$START_DIR"
tmux rename-window -t "$SESSION:1" "workspace"
tmux set-window-option -t "$SESSION:1" allow-rename off

# Step 1: pane 1 is full screen (will become admin)
#         split right → pane 1 = admin, pane 2 = worker+monitors
tmux select-pane -t "$SESSION:1.1"
tmux split-window -h -l 80%

# Step 2: pane 2 is active (worker+monitors)
#         split bottom → pane 2 = worker, pane 3 = monitor strip
tmux select-pane -t "$SESSION:1.2"
tmux split-window -v -l 25%

# Step 3: pane 3 is active (monitor strip)
#         split right → pane 3 = monitor 1, pane 4 = monitor 2
tmux select-pane -t "$SESSION:1.3"
tmux split-window -h -l 50%

# Land on the worker pane
tmux select-pane -t "$SESSION:1.2"

exec tmux attach-session -t "$SESSION"
