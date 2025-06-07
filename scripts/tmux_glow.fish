#!/usr/bin/env bash

set glow_command "glow -tl"

set markdown_file ""

function create_glow_command
    # get most recent used command
    set cmd (history -n 1)
    
    # split the cmd
    set command_split (string split ' ' $cmd) 

    # # find filename from command_split if command_split[1] is from an array of file edit/view commands
    # set view_edit_commands "emacs" "vim" "vi" "nvim" "nano" "micro" "ne" "cat" "bat" "less" "more" "most"

    # if not contains $command_split[1] $view_edit_commands
    #     # did not get an expected file terminal editor, so no need to update glow command
    #     return
    # end

    # # maybe logic can be simplified by ignoring checking of command list above and only check for the filename if its there
    # # idea of check above is to only open up the file in glow if viewing/editing file in terminal
    # # by removing check, any command with the file as last arg can open the file in glow

    if not string match -r "(?<file>\S+.md)" $command_split[-1]
        # did not file a file name/path to a markdown, so no need to update glow command
        return
    end

    set markdown_file[1] $file
end

function main
    echo "In fish script"

    set pane_current_path $argv[1]

    # change current directory of script to the current path
    cd $pane_current_path

    # set_markdown_file
    create_glow_command

    set glow_command[2] $markdown_file 

    tmux splitw -h -c "$pane_current_path"

    tmux send -t: "$glow_command" C-m
end

main $argv