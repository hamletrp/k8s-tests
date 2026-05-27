#!/usr/bin/env bash

SESSION="iot"
DIR="$(pwd)"

tmux new-session -d -s $SESSION -c "$DIR"

tmux split-window -h -t $SESSION:0 -c "$DIR"
tmux select-pane -t $SESSION:0.0
tmux split-window -v -t $SESSION:0.0 -c "$DIR"

tmux select-pane -t $SESSION:0.1
tmux resize-pane -R 20

# Start real interactive shells (so prompt looks correct)
tmux respawn-pane -t $SESSION:0.0 -k "cd \"$DIR\" && exec $SHELL -l"
tmux respawn-pane -t $SESSION:0.2 -k "cd \"$DIR\" && exec $SHELL -l"
tmux respawn-pane -t $SESSION:0.1 -k "cd \"$DIR\" && exec $SHELL -l"

tmux attach -t $SESSION