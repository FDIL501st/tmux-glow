#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux source "$CURRENT_DIR/tmux_glow_options.conf"

# depending on value of @glow_shell, a different script is binded to g
GLOW_SHELL=$(tmux show -gv "@glow_shell")

GLOW_HISTORY_WINDOW=$(tmux show -gv "@glow_history_window")

GLOW_BASH_HISTFILE=$(tmux show -gv "@glow_bash_histfile")

GLOW_ZSH_HISTFILE=$(tmux show -gv "@glow_zsh_histfile")

# unbind g if user already binded to something, this plugin will be using g
tmux unbind -q g

if [[ $GLOW_SHELL == "bash" ]]; then
    # bind to bash script
    tmux bind g run-shell "bash $CURRENT_DIR/scripts/tmux_glow.sh #{pane_current_path} $GLOW_HISTORY_WINDOW $GLOW_BASH_HISTFILE"

elif [[ $GLOW_SHELL == "fish" ]]; then
    # bind to fish script
    tmux bind g run-shell "fish $CURRENT_DIR/scripts/tmux_glow.fish #{pane_current_path} $GLOW_HISTORY_WINDOW"

elif [[ $GLOW_SHELL == "zsh" ]]; then
    # bind to zsh script
    tmux bind g run-shell "zsh $CURRENT_DIR/scripts/tmux_glow.zsh #{pane_current_path} $GLOW_HISTORY_WINDOW $GLOW_ZSH_HISTFILE"

else
    echo "Unsupported value of @glow_shell: "$GLOW_SHELL
    echo "Please use one of the supported values: bash, fish, zsh"
    exit 1
fi

