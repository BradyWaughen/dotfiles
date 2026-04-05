Open

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
 
# If session exists, just attach/switch to it
if tmux has-session -t "$SESSION" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$SESSION"
    else
        exec tmux attach-session -t "$SESSION"
    fi
    exit 0
fi
 
cd "$START_DIR" || exit 1
 
# Create the session detached
tmux new-session -d -s "$SESSION" -x "$(tput cols)" -y "$(tput lines)" -c "$START_DIR"
 
# Figure out what the first window index actually is (respects base-index)
FIRST_WIN=$(tmux list-windows -t "$SESSION" -F '#{window_index}' | head -1)
 
tmux rename-window -t "$SESSION:$FIRST_WIN" "workspace"
tmux set-window-option -t "$SESSION:$FIRST_WIN" allow-rename off
 
# Step 1: pane 1 is full screen (will become admin)
#         split right → pane 1 = admin, pane 2 = worker+monitors
tmux split-window -t "$SESSION:$FIRST_WIN.1" -h -l 80% -c "$START_DIR"
 
# Step 2: pane 2 (worker+monitors) split bottom → pane 2 = worker, pane 3 = monitor strip
tmux split-window -t "$SESSION:$FIRST_WIN.2" -v -l 25% -c "$START_DIR"
 
# Step 3: pane 3 (monitor strip) split right → pane 3 = monitor 1, pane 4 = monitor 2
tmux split-window -t "$SESSION:$FIRST_WIN.3" -h -l 50% -c "$START_DIR"
 
# Land on the worker pane
tmux select-pane -t "$SESSION:$FIRST_WIN.2"
 
# Attach or switch depending on whether we're already inside tmux
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION"
else
    exec tmux attach-session -t "$SESSION"
fi
