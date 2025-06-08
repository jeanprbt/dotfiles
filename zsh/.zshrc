# -------- P10K THEME --------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[[ -f "$HOME/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$HOME/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -------- HISTORY SETUP --------
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history hist_ignore_dups hist_expire_dups_first hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# -------- PATH --------
export PATH="$HOME/.local/bin:$PATH"

# -------- AUTO-SUGGESTIONS --------
source ~/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# -------- COMPLETIONS SETUP --------
source ~/.zsh_plugins/fzf-tab/fzf-tab.plugin.zsh
fpath=(~/.dotfiles/zsh/completions \\$fpath)
if [[ -d "/opt/homebrew/share/zsh/site-functions" ]]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
elif [[ -d "/usr/share/zsh/site-functions" ]]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
elif [[ -d "/usr/local/share/zsh/site-functions" ]]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi
autoload -Uz compinit && compinit

# ------ SYNTAX HIGHLIGHTING ------
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=white,bg=none'

# -------- FZF --------
eval "$(fzf --zsh)"
export FZF_COMPLETION_TRIGGER=','
if [[ "$(uname)" == "Linux" ]]; then
	export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .idea --exclude venv'
else
	export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .idea --exclude venv'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .idea --exclude venv'

_fzf_compgen_path() {
	fd --hidden --exclude .git --exclude node_modules --exclude .idea --exclude venv . "$1"
}
_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git --exclude node_modules --exclude .idea --exclude venv . "$1"
}

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

# ------ BAT (BETTER CAT) ------
export BAT_THEME="ansi"

# ------ ZOXIDE (BETTER CD) ------
eval "$(zoxide init zsh)"

# ------ SCAT (CUSTOM SUPER CAT) ------
scat() {
    lowercase() {
        echo "$1" | tr '[:upper:]' '[:lower:]'
    }
    if [[ "$(uname)" == "Linux" ]]; then
        BAT_CMD="batcat"
    else
        BAT_CMD="bat"
    fi
    if [ $# -eq 0 ]; then
        echo "Usage: scat <file|directory>"
    fi
    for file in "$@"; do
        if [ ! -e "$file" ]; then
            echo "File or directory not found: $file"
            continue
        fi
        if [ -d "$file" ]; then
            if command -v eza >/dev/null 2>&1; then
                eza --tree --color=always "$file" | head -200
            else
                ls -l "$file" | head -200
            fi
            continue
        fi
        extension="${file##*.}"
        extension=$(lowercase "$extension")
        case "$extension" in
        md | markdown)
            if command -v mdcat >/dev/null 2>&1; then
                mdcat "$file"
            else
                cat "$file"
            fi
            ;;
        pdf)
            if command -v tdf >/dev/null 2>&1; then
                tdf "$file"
            else
                cat "$file"
            fi
            ;;
        jpg | jpeg | png | gif | bmp | tiff)
            if command -v kitty >/dev/null 2>&1; then
                kitty +kitten icat "$file"
            else
                cat "$file"
            fi
            ;;
        *)
            if command -v "$BAT_CMD" >/dev/null 2>&1; then
                "$BAT_CMD" "$file"
            else
                cat "$file"
            fi
            ;;
        esac
    done
}

# ------ ALIASES ------
alias ls="eza --color=always --git --icons=always --oneline"
alias cd="z"
alias cat="scat"
alias python="python3"
alias pip="pip3"
if [[ "$(uname)" == "Linux" ]]; then
  if command -v batcat >/dev/null 2>&1; then
    alias bat="batcat"
  fi
  if command -v fdfind >/dev/null 2>&1; then
    alias fd="fdfind" 
  fi
fi

# -------- KITTY THEME TOGGLING --------
KITTY_FILE="$HOME/.config/kitty/kitty.conf"
if [[ "$(uname)" == "Linux" ]]; then
	SED_INPLACE=(-i '')
elif [[ "$(uname)" == "Darwin" ]]; then
	SED_INPLACE=(-i)
else
	echo "Unsupported OS: $(uname)"
	SED_INPLACE=()
fi
if [ -f "$KITTY_FILE" ]; then
    if command -v kitty >/dev/null 2>&1; then
	toggle-theme() {
		current_theme=$(awk '$1=="include" {print $2}' "$KITTY_FILE")
		new_theme="rose-pine-moon.conf"
		if [ "$current_theme" = "rose-pine-moon.conf" ]; then
			new_theme="rose-pine-dawn.conf"
			alias nvim='nvim --cmd "set background=light"'
			sed "$SED_INPLACE" 's/393552/faf4ed/g' "$KITTY_FILE"
		else 
			alias nvim='nvim --cmd "set background=dark"'
			sed "$SED_INPLACE" 's/faf4ed/393552/g' "$KITTY_FILE"
		fi
		kitty @ set-colors --all --configured "$HOME/.config/kitty/$new_theme"
		sed "$SED_INPLACE" -e "s|^include .*|include $new_theme|" "$KITTY_FILE"
	    	if [ -n "$KITTY_PID" ]; then
			kill -SIGUSR1 "$KITTY_PID"
		fi
	}
	current_theme=$(awk '$1=="include" {print $2}' "$KITTY_FILE")
	if [ "$current_theme" = "rose-pine-moon.conf" ]; then
	    alias nvim='nvim --cmd "set background=dark"'
	else 
		alias nvim='nvim --cmd "set background=light"'
	fi
    fi
fi
