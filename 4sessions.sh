#!/bin/bash

SESSION="quad"

tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION
    
    # Split into 4 panes
    tmux split-window -h -t $SESSION
    tmux split-window -v -t $SESSION:0.0
    tmux split-window -v -t $SESSION:0.1
    
    tmux select-layout -t $SESSION tiled
fi

tmux attach -t $SESSION
