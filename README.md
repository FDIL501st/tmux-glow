# tmux-glow

This plugin is inspired by a YouTube video, 
[link to video, go to around 7:00](https://www.youtube.com/watch?v=8kNF4TY6BVg)

At the moment,this plugin works for users of fish
(as I use fish as my main shell). Bash support not added yet. 


## What this plugin do?
When you press `prefix + g`, you will create a vertical pane,
in which glow is run. 
If your last used command was opening a markdown file
in a terminal editor, then that file is opened up in glow.
Otherwise, the pane has glow started without a file given. 

### Expected use case
The expected use case is for a quick way to 
view a rendered version of the markdown file you are currently
editing in your tmux window.

## Requirements
- glow
- fish

### glow
This plugin uses glow. 
Not having glow will throw errors when trying to use this plugin.

[Link to glow GitHub](https://github.com/charmbracelet/glow)


### fish
At the moment the plugin requirements requires fish.
This plugin assumes fish the main shell you use.

[Link to fish shell](https://fishshell.com)


## Non-fish users
Not using fish doesn't mean the plugin won't work.
Having fish installed does mean the plugin will work without
throwing errors.

What will not work is the use case of opening the markdown file
you are editing. The fish script looks into fish history.
This means you will run glow without a file opened,
and need to manually select your markdown file from the glow tui.


## Future plans

### Idea 1
Have a way to kill the pane with the same keybind. 
Turning `prefix+g` into a way to both open and close the glow pane.

Not sure how to do this, internally save state with a file?
This leads to an issue of not being able to have this work
on multiple windows. 

A good way would be to send all the currently running commands 
of all the panes in the window to the script. 
If find a pane running glow, kill that pane. 
Otherwise do what this plugin currently does.

However can simply not implement this as technically unlike
opening a new pane and running glow, 
killing a pane isn't that much work. 
With tmux all you have to do is go to glow pane,
then kill the pane with a keybind. 
Not much time saving compared to typing in the glow command
to open up a file.

### Idea 2
Another idea is to change how this plugin works.
Instead of basing it off your last used command,
find and open markdown based off your current directory.
This means looking into the current directory if it has a markdown file or not.
If it finds one, open it. Else run glow with no files.
This idea won't search into subdirectories, will keep it simple.
Main downside is if a directory has more than 1 markdown,
as then it is possible to open up the incorrect one.
