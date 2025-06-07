#!/usr/bin/env bash

HISTFILE="${HOME}/.bash_history"

view_history() {
    set -o history
    echo "$HISTFILE"
    history 5
    set +o history
}


main() {
    view_history
}

main
