if status is-interactive
	set fish_greeting ""
	set -gx TERM xterm-256color

  alias g 'git'
  alias k 'kubecolor'
  alias gs 'git status'
  alias c 'clear'
  alias v 'vagrant'
  alias ls 'eza -g -l --icons'
  alias t 'tmux'
  alias tf 'terraform'
  alias vi 'nvim'

  function tn
    tmux new -s (basename (pwd))
  end

  function ksn
    kubectl config set-context --current --namespace=$argv
  end

	set -gx EDITOR nvim

  set -U fish_user_paths /Users/thangrangto/.local/bin $fish_user_paths

  # Postgresql compiler
  set -gx LDFLAGS "-L/opt/homebrew/opt/postgresql@17/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/postgresql@17/include"
end

eval "$(/opt/homebrew/bin/brew shellenv)"
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

fish_add_path /opt/homebrew/opt/postgresql@17/bin
