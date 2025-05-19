#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind g run-shell "bash $CURRENT_DIR/scripts/tmux_glow.sh #{pane_current_path}"
