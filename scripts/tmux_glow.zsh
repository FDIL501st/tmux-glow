#!/usr/bin/env zsh


glow_command="glow -tl"
markdown_file=""

# Function to set markdown_file
set_markdown_file() {
    # Look for *.md files in the current directory (no subdirectories)
    # Use (N) qualifier to return empty array if no matches
    md_files=(*.md(N))
    
    # Check if we have any md files
    # In Zsh, arrays are 1-indexed
    if (( #md_files > 0 )); then
        markdown_file=${md_files[1]}
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
