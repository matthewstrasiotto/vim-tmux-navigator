#!/usr/bin/env bash

# https://github.com/NHDaly/tmux-better-mouse-mode/blob/aa59077/scripts/helpers.sh#L1-L10
get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
tmux bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
tmux bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
tmux bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
tmux bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

tmux bind-key -T copy-mode-vi C-h select-pane -L
tmux bind-key -T copy-mode-vi C-j select-pane -D
tmux bind-key -T copy-mode-vi C-k select-pane -U
tmux bind-key -T copy-mode-vi C-l select-pane -R
tmux bind-key -T copy-mode-vi C-\\ select-pane -l
