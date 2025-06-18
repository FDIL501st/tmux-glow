#!/usr/bin/env fish

set markdown_file ""

function set_markdown_file
    set cmds (history -n $argv[1])
    # by default is newest to oldest (what we want)

    set md_files (string match -r -a '\S+\.md' -- $cmds)

    # got all .md files from past commands

    # set the first one that is valid

    for md_file in $md_files
        if test -f "$md_file"
            set markdown_file[1] $md_file
            return
        end
    end
end

function main
    set pane_current_path $argv[1]

    # change current directory of script to the current path of pane
    cd $pane_current_path

    # set_markdown_file
    set_markdown_file $argv[2]

    set glow_command "glow -tl $markdown_file" 

    tmux splitw -h -c "$pane_current_path"

    tmux send -t: "$glow_command" C-m
end

main $argv