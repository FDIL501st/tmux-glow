# tmux-glow

This plugin is inspired by a YouTube video, 
[link to video, go to around 7:00](https://www.youtube.com/watch?v=8kNF4TY6BVg)

## Installation

### TPM (Recommended)

If you have tpm, add the following line to your tmux.conf file.

```bash
set -g @plugin 'FDIL501st/tmux-glow'
```

### Manual installation

Choose a location to clone this repo. For these steps we will use `~/.config/tmux/`.

1. Clone the repo:
```bash
git clone https://github.com/FDIL501st/tmux-glow.git ~/.config/tmux/tmux-glow
```

2. Add the following line to your `tmux.conf`:

`run ~/.config/tmux/tmux-glow/tmux_glow.tmux`

3. Reload (or restart) your tmux configurations

## What this plugin do?
When you press `prefix + g`, you will create a vertical pane,
in which glow is called. 
If the current directory has a markdown file, it will be opened up using glow.
Otherwise you will need to look for your file within glow.

### Example of use case
When editing a markdown in the terminal, you can use this plugin to quickly create a preview pane on the right to see the markdown render while you edit it.

### Some before and after images of this plugin in action

Below I have 3 pairs of before and after images. The after is the result of what you see after pressing `prefix + g`.

###### Do ignore the lack of nerdfont in the images. I took the screenshots using my dotfiles test VM, which is I did not fully setup.

#### Before (fish shell with markdown present)
![Before fish (with markdown)](images/fish_start_with_md.png)
#### After (fish shell with markdown present)
![After fish (with markdown)](images/fish_plugin_with_md.png)

#### Before (fish shell without markdown present)
![Before fish (without markdown)](images/fish_start_without_md.png)
#### After (fish shell without markdown present)
![After fish (withouth markdown)](images/fish_plugin_without_md.png)

#### Before (bash shell with markdown present)
![Before bash](images/bash_start_with_md.png)
#### After (bash shell with markdown present)
![After bash](images/bash_plugin_with_md.png)

#### Limitations
A major limitation is if a directory has multiple markdown files in it.
Only the first that is listed with ls is opened. With the current implementation,
there is no easy to reach the other markdown file within glow.
My current testing has shown me if I try to look for files with glow (after opening up a markdown file),
then glow will not find any files at all. 
This issue of glow not finding files does not occur if this plugin doesn't open a markdown file in glow 
(meaning the current directory doesn't have a markdown file in it).
This bug from my understanding is one with glow itself (at least the version I have, 2.1.0).

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

This expected output is `"Hello world from fish"`

[Link to fish shell](https://fishshell.com)


## Future plans
### Idea 1
Remove the fish requirement by replacing the 
tmux_glow.fish with tmux_glow.sh. This means rewriting with bash instead of fish. 

This is because I assume most people are not like me that uses fish as their main shell. For bash or zsh users, I'm pretty sure they won't like the idea of having to install a shell just to run some scripts for a tmux plugin.

I believe this plugin will be more accessible if I rewrite the fish scripts with bash instead.
### Idea 2
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

### Idea 3
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
