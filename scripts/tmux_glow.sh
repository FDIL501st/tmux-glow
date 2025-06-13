#!/usr/bin/env bash

glow_command="glow -tl"
markdown_file=""
BASH_HISTFILE="${HOME}/.bash_history"


# function that asserts that BASH_HISTFILE is a valid file
assert_bash_histfile_exists() {
	if ! [[ -f $BASH_HISTFILE ]]; then
		echo "Unable to find the bash history file: $BASH_HISTFILE"
		exit 1
	fi
}

# function to set markdown_file
set_markdown_file() {
	# look for .md file in last 10 commands in history
	# we make an assumption each line is a command, multi-line commands break this assumption
	readarray -t md_files < <(tail -n 10 "$BASH_HISTFILE" | awk '$NF ~ /\.md$/ {print $NF}' | tac)
	# use awk to get markdown file names, we make an assumption that with terminal printing or editing of .md files
	# the .md file will be the last argument

	# we pipe result into tac to reverse the result from awk (so first element is most recent used command)

	# we need to check each md_file found if its valid
	# as it is possible to match *.md (eg. ls *.md) or 
	# commands from a different session that appened to history more recently
	for md_file in "${md_files[@]}"; do
		if [[ -f $md_file ]]; then
			markdown_file=$md_file 
			break
		fi 
	done
	# if no md_file found or none worked, then we do nothing
	# it is safe for markdown_file to stay ""
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
