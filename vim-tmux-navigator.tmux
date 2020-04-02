#!/usr/bin/env bash

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
tmux bind-key -n C-Left if-shell "$is_vim" "send-keys C-Left"  "select-pane -L"
tmux bind-key -n C-Down if-shell "$is_vim" "send-keys C-Down"  "select-pane -D"
tmux bind-key -n C-Up if-shell "$is_vim" "send-keys C-Up"  "select-pane -U"
tmux bind-key -n C-Right if-shell "$is_vim" "send-keys C-Right"  "select-pane -R"
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -Right'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

tmux bind-key -T copy-mode-vi C-Left select-pane -L
tmux bind-key -T copy-mode-vi C-Down select-pane -D
tmux bind-key -T copy-mode-vi C-Up select-pane -U
tmux bind-key -T copy-mode-vi C-Right select-pane -R
tmux bind-key -T copy-mode-vi C-\\ select-pane -l
