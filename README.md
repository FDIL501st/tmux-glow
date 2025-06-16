# tmux-glow

This plugin is inspired by a YouTube video, 
[link to video, go to around 7:00](https://www.youtube.com/watch?v=8kNF4TY6BVg)

## Requirements
- glow

### glow
This plugin uses glow. 
Not having glow will throw errors when trying to use this plugin 
as the command won't be found.

[Link to glow GitHub](https://github.com/charmbracelet/glow)


## Installation

### TPM (Recommended)

If you have tpm, add the following line to your tmux.conf file.

```bash
set -g @plugin 'FDIL501st/tmux-glow'
```
Then reload your tmux configurations.
### Manual installation

Choose a location to clone this repo. For these steps we will use `~/.config/tmux/`.

1. Clone the repo:
```bash
git clone https://github.com/FDIL501st/tmux-glow.git ~/.config/tmux/tmux-glow
```

2. Add the following line to your `tmux.conf`:

`run ~/.config/tmux/tmux-glow/tmux_glow.tmux`

3. Reload your tmux configurations

### Installation Part II

Depending on your default shell (for tmux), you might need to edit some shell configuration files.
For example:
- `.bashrc`
- `.zshrc`


#### bash users
Add the following lines to `.bashrc` if you don't already have these:

```bash
PROMPT_COMMAND="history -a"
```

Setting `PROMPT_COMMAND` is essential for this plugin to work. What it does is the commands you type are immediatly appended
to your bash history file. This is important as when looking for a recently used markdown file, this plugin
looks into your bash history file. Without setting PROMPT_COMMAND, by default bash will only write your current's session history into your history file when it closes. This means when the script looks into your bash history file, without setting `PROMPT_COMMAND`, the script will not be able to view your current session's most recent command.

If you already have set PROMPT_COMMAND without `history -a`, you can add the following line instead:
```bash
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
```
This will ensure PROMPT_COMMAND has your previous settings, and `history -a` needed for this plugin to work.

#### zsh users
Add the following line to `.zshrc` if you don't already have this:

```zsh
setopt INC_APPEND_HISTORY
```
What this does is have your zsh history file immediately have the commands you used append to it, instead of when you close your session (which is default).

This plugin looks into your zsh history file for your recently used commands, so the file not being up to date to your session history will make this plugin not work.

#### fish users
No extra configurations needed. 


## What this plugin do?
When you press `prefix + g`, you will create a vertical pane,
in which glow is called. 
If the current directory has a markdown file, it will be opened up using glow.
Otherwise you will need to look for your file within glow.

### Example of use case
When editing a markdown in the terminal, you can use this plugin to quickly create a preview pane on the right to see the markdown render while you edit it.

### Some before and after images of this plugin in action (Outdated images)

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

### Idea 2 (Currently being worked on)
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
