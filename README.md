# tmux-glow

This plugin is inspired by a YouTube video, 
[link to video, go to around 7:00](https://www.youtube.com/watch?v=8kNF4TY6BVg)

## Installation
If you have tpm, add the following line to your tmux.conf file.

```bash
set -g @plugin 'FDIL501st/tmux-glow'
```


## What this plugin do?
When you press `prefix + g`, you will create a vertical pane,
in which glow is run. 
If the current directory has a markdown file, it will be opened up using glow.
Otherwise you will need to look for your file within glow.

### Expected use case
The expected use case is for a quick way to 
view a rendered version of the markdown file in your current directory.

#### Limitations
A major limitation is if a directory has multiple markdown files in it.
Only the first that is listed with ls is opened. With the current implementation,
there is no easy to reach the other markdown file within glow.
My current testing has shown me if I try to look for files with glow (after opening up a markdown file),
then glow will not find any files at all. 
This issue of glow not finding files does not occur if this plugin doesn't open a markdown file in glow 
(meaning the current directory doesn't have a markdown file in it).

A minor limitation is that this plugin will not search inside subdirectories.
This is by design, not searching inside subdirectories will not be changed.


## Requirements
- glow
- fish

### glow
This plugin uses glow. 
Not having glow will throw errors when trying to use this plugin 
as the command won't be found.

[Link to glow GitHub](https://github.com/charmbracelet/glow)


### fish
At the moment the plugin requirements requires fish.
You only need to be able to run fish scripts, as this plugin runs that, not bash scripts.
Your main shell does not have to be fish.
If you are able to run the test script in this repo with the following command:
```fish
fish test.fish
```
then you meet this requirement.

[Link to fish shell](https://fishshell.com)


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
Instead of basing it off of a markdown file existing in the current directory,
make it based off of last command used/history.
If the previous used command was viewing or editing a markdown file in 
the terminal, 
then the plugin will open the markdown in glow.
Otherwise glow will open with no file.

Downside to this is code can't be shared between different shell users, 
unlike current directory based. Each shell has its own history.
Depending on a user's main shell, the script checking the history 
must match the user's main shell. Otherwise the plugin will never find
a markdown file to open.
