#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux source "$CURRENT_DIR/tmux_glow_options.conf"


# depending on value of @glow_shell, a different script and shell command is binded to g

GLOW_SHELL=$(tmux show -gv "@glow_shell")

# manual override to test plugin
GLOW_SHELL="zsh"

# unbind g if user already binded to something, this plugin will be using g
tmux unbind -q g

if [[ $GLOW_SHELL == "bash" ]]; then
    # COMMAND="bash $CURRENT_DIR/scripts/tmux_glow.sh #{pane_current_path}"
    tmux bind g run-shell "bash $CURRENT_DIR/scripts/tmux_glow.sh #{pane_current_path}"

elif [[ $GLOW_SHELL == "fish" ]]; then
    # bind to the fish script
    # COMMAND="fish $CURRENT_DIR/scripts/tmux_glow.fish #{pane_current_path}"
    tmux bind g run-shell "fish $CURRENT_DIR/scripts/tmux_glow.fish #{pane_current_path}"

elif [[ $GLOW_SHELL == "zsh" ]]; then
    # bind to zsh script
    tmux bind g run-shell "zsh $CURRENT_DIR/scripts/tmux_glow.zsh #{pane_current_path}"

else
    echo "Unsupported value of @glow_shell: "$GLOW_SHELL
    echo "Please use one of the supported values: bash, fish, zsh"
    exit 1
fi

