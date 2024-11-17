# My terminal configuration
This repository contains all the needed configuration files for an outstanding terminal featuring **multi-tabs** & **pane-splitting**, **images display**, **refined** common commands and an amazing **IDE-like text editor**. 

It was curated for **macOS**, but most of the functionality is also available for **Linux**. It leverages awesome [`Rosé Pine`](https://rosepinetheme.com) theme, offering both light & dark modes, as well as [`MesloLGS`](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) font.

![hero](./docs/hero.png)

## Overview
The whole configuration relies on three components.
- A shell => [`zsh`](https://fr.wikipedia.org/wiki/Z_Shell)
- A terminal emulator => [`kitty`](https://sw.kovidgoyal.net/kitty/)
- An embedded IDE => [`neovim`](https://neovim.io)

*You can find details on each of these core components below*.

## Installation
In order to install the present configuration, you can clone this directory on your own system and create symbolic links to the files/folders of interest.

+ Install `zsh`, `kitty` & `neovim` on your system. 
````sh
brew install zsh kitty neovim
````

+ Back up your current configuration files.
```sh
mv ~/.zshrc ~/.zshrc.bak
mv ~/.config/kitty ~/.config/kitty.bak
mv ~/.config/nvim ~/.config/nvim.bak
```

+ Clone this repo in your `$HOME` directory.
```sh
git clone https://github.com/jeanprbt/dotfiles.git ~/.dotfiles
```

+ Create symlinks to your `$HOME` directory.
```sh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/kitty ~/.config/kitty
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

+ Start `kitty`, and you should be done !


### Configuration details


#### `zsh`

Let's start with the shell ! `zsh` is the default shell on macOS, its single configuration file (`.zshrc`) is located in your `$HOME` directory by default. Sections below follow the order of the file, feel free to open it on the side to have a better understanding of what I'm talking about. 

##### Theme

I use [`powerlevel10k`](https://github.com/romkatv/powerlevel10k) as my `zsh` theme. It's easy to configure using the built-in command `p10k configure`, feel free to run it so as to get your own favorite look. 

##### History

I configured the `Up` and `Down` arrow keys to go through your command history.

##### Auto suggestions

I use [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) plugin to get suggestions as I type, which can save a lot of time at some points.

##### Completions

`zsh` completions using the `<Tab>` key only include the files/folders in your current directory by default. I added many third-party integrations such as `git` command completion, `gh`, `docker`, `brew`, `jupyter`, `conda` and so on. Many of these are simple files in my `~/.zsh/` folder prepended with `_`, that I source using `fpath` utility.

##### Syntax Highlighting

A very useful feature is having syntax highlighting over valid commands. This is made possible thanks to [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting/tree/master) plugin.

##### Fuzzy-Search

I use [`fzf`](https://github.com/junegunn/fzf) extensively, so as to fuzzy-search through my files & preview them, find my ssh hosts, explore my previous commands etc. When typing a command, I can type `,` and then hit `<Tab>` to launch `fzf` over the according category.

| Command | `fzf` category |
| -------------- | --------------- |
| `cd ,` + `<Tab>` | folders |
| `export/unset ,` + `<Tab>` | env. variables |
| `ssh ,` + `<Tab>` | ssh hosts |
| `<anything_else> ,` + `<Tab>` | files & folders |

I configured `<C-r>` shortcut to go through my previous commands, and `C-t` shortcut to preview files in the current directoty. Thanks to `kitty`, previw supports all kind of non-binary files, as well as `pdf`, `markdown` and `jpg/png` files.

##### Super-`cat`

Thanks to `kitty` terminal and its image graphics protocol, I designed a super-`cat` command to display pretty much everything I need to display. Setting an alias for `cat`, I can seamlessly output `pdf`, `markdown`, `jpg/png` files as well as more standard files, that are prettier thanks to [`bat`](https://github.com/sharkdp/bat). You can enable this command adding your `dotfiles` repository to your `$PATH`, or creating a symlink from one directory on your `$PATH` to the `scat` file. 

![images](./docs/image.png)
![pdf](./docs/pdf.png)


##### Better `ls`

I use the awesome [`eza`](https://github.com/eza-community/eza) command as an alternative to `ls`.

##### Mistakes recovery

Way too often I hit `<Enter>` too soon, forgetting one blank space in a 3-lines-long command. Instead of typing it again, I use [`thefuck`](https://github.com/eza-community/eza) corrector which does it for me.

##### Better `cd`

I use the awesome [`zoxide`](https://github.com/ajeetdsouza/zoxide) command as a replacement for `cd`. It allows me to only type partial paths, that are remembered instad of typing the whole absolute path of where I want to go.

##### Theme toggling

I designed a small script to toggle my theme from dark to light and conversely, providing a seamless `toggle-theme` command which does everything under the hood.


That's pretty much everything that is interesting in my `zsh` config !


#### `kitty`

Let's carry on with the terminal emulator ! `kitty` is one of the most advanced out there. What makes it so special is its graphics protocol, which enables viewing images using a full resolution directly within the terminal. Out of the box, it already features pane-splitting and multi-tabs, but I've set some custom shortcuts to really make this emulator mine. Most of the configuration happens in file `kitty.conf`, which can be extended using additional `.py` files. 

##### Tab bar

The built-in tab bar was not enough for me, that's why I added a custom bar (thanks to this [comment](https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-8736005)) using `tab_bar.py` file. It displays current window in a prettier way, and adds the current kitty [layout](https://sw.kovidgoyal.net/kitty/layouts/), the number of panes and the time on the right.

##### Search

`kitty` does not have a built-in search, that's why I had to use this [plugin](https://github.com/trygveaa/kitty-kitten-search), which adds additional files `scroll_mark.py` and `search.py`.

##### Shortcuts

I decided to keep all shortcuts involving the `cmd` key for `kitty`.

| Shortcut | Action |
| -------------- | --------------- |
| `<cmd-k>` | clear terminal |
| `<cmd-c>`/`<cmd-v>` | copy/paste |
| `<ctrl-/>`| vertical split |
| `<ctrl-_>`| horizontal split |
| `<cmd-enter>`| new window |
| `<cmd-enter>`| new window |

