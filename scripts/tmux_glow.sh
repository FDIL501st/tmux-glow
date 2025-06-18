#!/usr/bin/env bash

# global variables
markdown_file=""
BASH_HISTFILE=""


# function that asserts that BASH_HISTFILE is a valid file
function assert_bash_histfile_exists() {
	if ! [[ -f $BASH_HISTFILE ]]; then
		echo "Unable to find the bash history file: $BASH_HISTFILE"
		exit 1
	fi
}

# function to set markdown_file
function set_markdown_file() {
	# look for .md file in last 10 commands in history (newest to oldest)
	# we make an assumption each line is a command, multi-line commands break this assumption
	readarray -t cmds < <(tail -n "$1" "$BASH_HISTFILE"| tac)

	# Extract all substrings matching '\S+\.md' (non-space characters followed by .md)
	readarray -t md_files < <(echo "${cmds[@]}" | grep -o -E '\S+\.md')

	# Check each matched file and output the first existing one
	for md_file in "${md_files[@]}"; do
		if [[ -f "$md_file" ]]; then
			markdown_file="$md_file"
			return
		fi
	done
	# if no md_file found or none worked, then we do nothing
	# it is safe for markdown_file to stay ""
}

function main() {
	BASH_HISTFILE="$3"

	# first assert that bash history file exists
	assert_bash_histfile_exists

	pane_current_path="$1"

	# change current directory of script to the current path of pane
	cd "$pane_current_path" || exit 
	# use || exit in case cd fails, then programs stops cd exit code

	# use (()) so string get converted to a number,  the inner brackets is for arthimetics
	set_markdown_file $(($2))

	# create_glow_command
	glow_command="glow -tl $markdown_file"

	tmux splitw -h -c "$pane_current_path"

	tmux send -t: "$glow_command" C-m
}

main "$@"
