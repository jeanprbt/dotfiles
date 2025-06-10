# My terminal configuration

This repository contains all the needed configuration files for an outstanding terminal featuring multi-tabs, pane-splitting, images display, improved common commands and an amazing IDE-like text editor.

It was curated for **macOS** and **Linux**, and it leverages awesome [`Rosé Pine`](https://rosepinetheme.com) theme, offering both light & dark modes, as well as [`MesloLGS`](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Meslo) font.

![hero](./docs/hero.png)

## Installation

The whole configuration relies on $3$ components.

- A shell => [`zsh`](https://fr.wikipedia.org/wiki/Z_Shell)
- A terminal emulator => [`kitty`](https://sw.kovidgoyal.net/kitty/)
- An embedded IDE => [`neovim`](https://neovim.io)

Let's dive into each of these components step-by-step. The configuration is adapted to both **macOS** & **Linux**, please follow the next instructions according to your OS. To get started, clone this repository in your `$HOME` directory.

```sh
git clone https://github.com/jeanprbt/dotfiles.git ~/.dotfiles
```

### Shell

You need to make sure that your shell is `zsh`, using `echo $SHELL`. It should be case on macOS since it is the default shell, here's how to change it otherwise.

```sh
apt update
apt install zsh
chsh -s $(which zsh)
```

Restart your shell, and now the previous command should output the path of your `zsh` executable. Then, let's install the core tools of the configuration.

| Package | Purpose | macOS (Homebrew) | Linux (apt/pacman/etc.) |
| --- | --- | --- | --- |
| [git](https://git-scm.com/downloads) | Needless to say ;) | `brew install git` | `apt install git` |
| [fzf](https://junegunn.github.io/fzf/) | Fuzzy search | `brew install fzf` | `apt install fzf` (ensure -v >= 0.48.0) |
| [fd](https://github.com/sharkdp/fd) | Better `find` | `brew install fd` | `apt install fd-find` |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Better `cd` | `brew install zoxide` | `apt install zoxide` |
| [eza](https://github.com/eza-community/eza) | Better `ls` | `brew install eza` | Follow [instructions](https://github.com/eza-community/eza/blob/main/INSTALL.md) |
| [bat](https://github.com/sharkdp/bat) | Better `cat` | `brew install bat` | `apt install bat` |
| [poppler](https://poppler.freedesktop.org/) & [imagemagick](https://imagemagick.org/) | PDF preview rendering | `brew install poppler imagemagick` | `apt install poppler-utils imagemagick `</div> |

Optionally, you can install the following tools to get a better display of `.md` files and be able to go through PDFs directly within your terminal.

| Package | Purpose | macOS (Homebrew) | Linux (apt/pacman/etc.) |
| --- | --- | --- | --- |
| [mdcat](https://github.com/swsnr/mdcat) | Prettier markdown display | `brew install mdcat`  | Follow [instructions](https://github.com/swsnr/mdcat)  |
| [tdf](https://github.com/itsjunetime/tdf) | PDF rendering | Follow [instructions](https://github.com/itsjunetime/tdf?tab=readme-ov-file) | same |

Next, let's install some useful `zsh` plugins in their dedicated directory to be easily sourced.

```sh
mkdir -p ~/.zsh_plugins && cd ~/.zsh_plugins
git clone https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab
```

Finally, include the configuration files of this repository in your `~/.zshrc` file. If you don't have one, create it.

```sh
# .zshrc
source ~/.dotfiles/zsh/.zshrc
```

Restart your shell again or run `exec zsh`, and you're good to go with the shell! You're seeing the default layout of [powerlevel10k](https://github.com/romkatv/powerlevel10k), feel free to run `p10k configure` to meet your needs.

### Terminal emulator

Let's install the font for this configuration, namely [Meslo](https://github.com/andreberg/Meslo-Font). Here's how to check if it is already downloaded.

```sh
fc-cache -fv
fc-list | grep -i meslo 
```

If nothing appears, follow these instructions.

- **macOS**

    ```sh
    brew install --cask font-meslo-lg-nerd-font
    ```

- **Linux**

    ```sh
    mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
    unzip Meslo.zip && rm Meslo.zip
    ```

Next, let's install [kitty](https://sw.kovidgoyal.net/kitty/)!

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

We are ready to create a symlink to the terminal emulator configuration files of this repository.

```sh
mv ~/.config/kitty ~/.config/kitty.bak # back up your current config
ln -s ~/.dotfiles/kitty ~/.config/
```

Start kitty, and enjoy your new terminal!

### Embedded IDE

As you may have noticed, we will rely on [neovim](https://neovim.io/) for this one. Let's install it.

| macOS (Homebrew) | Linux (apt/pacman/etc.) |
| --- | --- |
| `brew install neovim`  | `apt install neovim` (ensure -v >= 0.10.0) |

Let's also install additional tools it will rely on.

| Package | Purpose | macOS (Homebrew) | Linux (apt/pacman/etc.) |
| --- | --- | --- | --- |
| [node](https://nodejs.org/en) | Copilot runtime | `brew install node`  | Follow [instructions](https://nodejs.org/en/download) |
| [luarocks](https://luarocks.org/) | Lua package manager (see below) | `brew install luarocks` | `apt-get install luarocks` |
| [lua-magick](https://github.com/leafo/magick) | ImageMagick Lua bindings | `luarocks --local --lua-version=5.1 install magick` | same |
| [awrit](https://github.com/chase/awrit) | Terminal browser (markdown rendering) | `curl -fsS https://chase.github.io/awrit/get \| DOWNLOAD_TO=~/<download_dir> bash` | same |
