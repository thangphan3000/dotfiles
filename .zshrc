# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }

# ---------------------------- key binding ---------------------------

bindkey "^P" up-history
bindkey "^N" down-history

# ------------------------------- alias ------------------------------

alias ls="ls --color"

set-editor() {
	export EDITOR="$1"
	alias vi="\$EDITOR"
}

_have "vim" && set-editor vi
_have "nvim" && set-editor nvim

PROMPT="[%F{yellow}%n%f@devops  %F{lightblue}%~%f%F{white}]%f$ "

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

source <(fzf --zsh)
