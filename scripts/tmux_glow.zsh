#!/usr/bin/env zsh

# global variables
markdown_file=""
ZSH_HISTFILE=""


# function that asserts that ZSH_HISTFILE is a valid file
assert_zsh_histfile_exists() {
	if ! [[ -f $ZSH_HISTFILE ]]; then
		echo "Unable to find the zsh history file: $ZSH_HISTFILE"
		exit 1
	fi
}

# function to set markdown_file
set_markdown_file() {
	# read comments of tmux_glow.sh, this does that, replacing some bash things with zsh 

	cmds=(${(f)"$(tail -n 10 "$ZSH_HISTFILE" | tac)"})

	md_files=( ${(f)"$(echo "${cmds[@]}" | grep -o -E '\S+\.md')"} )

	for md_file in "${md_files[@]}"; do
		if [[ -f "$md_file" ]]; then
			markdown_file="$md_file"
			return
		fi 
	done
}

main() {
	ZSH_HISTFILE="$3"

	# first assert that bash history file exists
	assert_zsh_histfile_exists

	pane_current_path="$1"

	# change current directory of script to the current path of pane
	cd "$pane_current_path" || exit 
	# use || exit in case cd fails, then programs stops cd exit code

	# use (()) so string get converted to a number, the inner brackets is for arthimetics
	set_markdown_file $(($2))

	# create_glow_command
	glow_command="glow -tl $markdown_file"

	tmux splitw -h -c "$pane_current_path"

	tmux send -t: "$glow_command" C-m
}

main "$@"
