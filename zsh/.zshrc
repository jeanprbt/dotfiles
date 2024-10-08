
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# -- History setup --
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


# -- Auto suggestions --
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# -- Completions --

# Git
zstyle ':completion:*:*:git:*' script ~/.dotfiles/zsh/completions/git-completion.bash

# Brew
fpath=(/opt/homebrew/completions/zsh \\$fpath)

# Load other completions (git, gh, conda, etc.)
fpath=(~/.dotfiles/zsh/completions \\$fpath)
autoload -Uz compinit && compinit

# -- Syntax highlighting --
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white,bg=none'

# -- Set up fzf key bindings and fuzzy completion --
eval "$(fzf --zsh)"
export FZF_COMPLETION_TRIGGER=','

# -- Use fd instead of fzf --
# Ctrl-T
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .idea --exclude venv"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .idea --exclude venv"

  # **/
_fzf_compgen_path() {
 	fd --hidden --exclude .git --exclude node_modules --exclude .idea --exclude venv . "$1"
}
_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git --exclude node_modules --exclude .idea --exclude venv . "$1"
}

# -- Set up preview w/ fzf and bat --
show_file_or_dir_preview='
if [ -d {} ]; 
    then eza --tree --color=always {} | head -200; 
elif [[ {} =~ (".jpg"|".JPG"|".jpeg"|".png"|".PNG")$ ]]; 
    then kitten icat --clear --transfer-mode=memory --stdin=no --unicode-placeholder --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} | sed \$d; 
elif [[ {} =~ (".pdf"|".PDF")$ ]]; then 
    pdftoppm -singlefile {} -tiffcompression jpeg | kitten icat --transfer-mode=memory --unicode-placeholder --clear --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@20x1; 
elif [[ {} =~ (".md"|".MD")$ ]];
    then mdcat --columns ${FZF_PREVIEW_COLUMNS} {};
else 
    bat -n --color=always --line-range :500 {}; 
fi
'

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# -- Add support for files, ssh, env var. --
_fzf_comprun() {
	local command=$1
    shift
	case "$command" in
		cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
		export|unset) local var_name; var_name=$(awk -F'=' '{print $1}' <<< "$(echo {} | sed "s/^export //")"); fzf --preview "echo -n '$var_name: '; eval 'echo \${}'" "$@" ;;
		ssh)          fzf --preview 'dig {}'                   "$@" ;;
		*)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
	esac
}

# -- scat (super cat) --
export BAT_THEME="ansi"
alias cat="scat"

# -- eza (better ls) --
alias ls="eza --color=always --git --icons=always --oneline"

# -- TheF*ck (mis-spelled commands) -- 
# thefuck alias
eval $(thefuck --alias)

# -- Zoxide (better cd) --
eval "$(zoxide init zsh)"
alias cd="z"

# -- Python3 / Pip3 aliases --
alias python="python3"
alias pip="pip3"

# -- Image cat alias --
alias icat="kitten icat"

# -- Created by `pipx` --
export PATH="$PATH:/Users/jeanperbet/.local/bin"

# -- Virtualenvwrapper --
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/.virtualenvsprojs
export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/opt/homebrew/bin/virtualenv
source /opt/homebrew/bin/virtualenvwrapper.sh

# -- image.nvim --
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# -- Jupyter kernels --
export PYDEVD_DISABLE_FILE_VALIDATION=1

# go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# -- Theme toggling --
KITTY_FILE="$HOME/.config/kitty/kitty.conf"
toggle-theme() {
	current_theme=$(awk '$1=="include" {print $2}' "$HOME/.config/kitty/kitty.conf")
	new_theme="rose-pine-moon.conf"
	if [ "$current_theme" = "rose-pine-moon.conf" ]; then
		new_theme="rose-pine-dawn.conf"
        alias nvim='nvim --cmd "set background=light"'
        sed -i '' 's/393552/faf4ed/g' "$KITTY_FILE"
    else 
        alias nvim='nvim --cmd "set background=dark"'
        sed -i '' 's/faf4ed/393552/g' "$KITTY_FILE"
	fi
	kitty @ set-colors --all --configured "~/.config/kitty/$new_theme"
	sed -i '' -e "s/include.*/include $new_theme/" "$HOME/.config/kitty/kitty.conf"
    kill -SIGUSR1 $KITTY_PID
}
current_theme=$(awk '$1=="include" {print $2}' "$HOME/.config/kitty/kitty.conf")
if [ "$current_theme" = "rose-pine-moon.conf" ]; then
    alias nvim='nvim --cmd "set background=dark"'
else 
    alias nvim='nvim --cmd "set background=light"'
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
