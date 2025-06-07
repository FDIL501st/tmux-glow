#!/usr/bin/env zsh

glow_command="glow -tl"
markdown_file=""

# Function to set markdown_file
set_markdown_file() {
	# look for .md file in last 5 commands in history (use 5 as a way to search within recently used commands)
	md_file=$(history -5 | awk '$NF ~ /\.md$/ {print $NF}' | tail -n 1)
	# use awk to get markdown file names, make an assumption that with terminal printing or editing of .md files
	# the .md file will be the last argument

	# use tail -n 1 so we use the latest one if multiple commands with .md files found by history

    if [[ -z $md_file ]]; then
	# TODO: remove debug message 
		echo "No markdown file found"
	else 
		markdown_file=${md_file}
	fi

	
}

main() {
	echo "In zsh script"

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
