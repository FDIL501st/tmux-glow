#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind g run-shell "fish $CURRENT_DIR/scripts/tmux_glow.fish #{pane_current_path}"
