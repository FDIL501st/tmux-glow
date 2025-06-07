#!/usr/bin/env bash

glow_command="glow -tl"
markdown_file=""
BASH_HISTFILE="${HOME}/.bash_history"


# Function that asserts that BASH_HISTFILE is a valid file
assert_bash_histfile_exists() {
	if ! [[ -f $BASH_HISTFILE ]]; then
		echo "Unable to find the bash history file: $BASH_HISTFILE"
		exit 1
	fi
}

# Function to set markdown_file
set_markdown_file() {
	
	# first get last 5 lines from history (assumes that each line is a single command)
	# if a command is multi-line, this logic will fail

	echo "Last 5 lines: $(tail -n 5 "$BASH_HISTFILE")"

	# look for .md file in last 5 commands in history
	md_file=$(tail -n 5 "$BASH_HISTFILE" | awk '$NF ~ /\.md$/ {print $NF}' | tail -n 1)
	# use awk to get markdown file names, make an assumption that with terminal printing or editing of .md files
	# the .md file will be the last argument

	# use tail -n 1 so we use the latest one if multiple commands with .md files found by history


	# BUG: bash history inside tmux not stored in bash_history

	# fish does not have this problem as can use history, in bash can't use history to get history in shell scripts

	echo "md_file: $md_file"

    if [[ -z $md_file ]]; then
	# TODO: remove debug message 
		echo "No markdown file found"
	else 
		markdown_file=$md_file
	fi

}

main() {
	echo "In bash script"

	# first assert that bash history file exists
	assert_bash_histfile_exists

	pane_current_path=$1

	# change current directory of script to the current path
	cd "$pane_current_path" || exit 
	# use || exit in case cd fails, then programs stops cd exit code

	set_markdown_file

	# create_glow_command
	glow_command="$glow_command $markdown_file"

	tmux splitw -h -c "$pane_current_path"

	tmux send -t: "$glow_command" C-m
}

main "$@"
