#!/bin/bash

glow_command="glow -tl"
markdown_file=""

# Function to set markdown_file
set_markdown_file() {
    # Look for *.md files in the current directory (no subdirectories)
    md_files=(*.md)

    # if no .md files found, by default bash will set md_files to the string
    # so check if the string was not set to know current directory has a md file
    if [[ ${md_files[0]} != "*.md" ]]; then
      markdown_file=${md_files[0]}
    fi
}

# start of flow of script
pane_current_path=$1

# change current directory of script to the current path
cd $pane_current_path

set_markdown_file

# create_glow_command
glow_command="$glow_command $markdown_file"

tmux splitw -h -c "$pane_current_path"

tmux send -t: "$glow_command" C-m
