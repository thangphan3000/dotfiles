# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)" 
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

export XDG_CONFIG_HOME="$HOME/.config"

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

is_had() { type "$1" &>/dev/null;  }

set_editor() {
    export EDITOR="$1"
    alias vi="$EDITOR"
}

# History
HISTFIL=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Keybinding
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias ls="eza --icons -l -g"
alias k="kubectl"
alias c="clear"
alias t="tmux"
alias tf="terrform"
alias d="podman"
alias docker="podman"
alias t="tmux"
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gc="git commit -m $1"
alias tn="tmux new -s $1"
alias p="python"

is_had "vim" && set_editor vi
is_had "nvim" && set_editor nvim

# Shell integaration
is_had "zsh" && eval "$(fzf --zsh)"
is_had "zoxide" && eval "$(zoxide init --cmd cd zsh)"

# Environment variables
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# FZF
export FZF_DEFAULT_OPTS="\
--ansi \
--border rounded \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic' \
--marker=' ' \
--no-info \
--no-separator \
--pointer='👉' \
--reverse"

export FZF_TMUX_OPTS="-p 80%,70%"

export FZF_CTRL_R_OPTS="\
--border-label=' history ' \
--prompt='  '"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Added by `rbenv init` on Tue Jun  3 14:07:13 +07 2025
eval "$(rbenv init - --no-rehash zsh)"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@17/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@17/include"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
