#!/bin/bash

declare -a BREW_APPS=(
  'alacritty'
  'obsidian'
  'font-jetbrains-mono-nerd-font'
)

declare -a BREW_PACKAGES=(
  'tree'
  'eza'
  'neovim'
  'tmux'
  'awscli'
  'ripgrep'
  'asdf'
  'fzf'
  'lazygit'
  'git-delta'
)

is_had() { type "$1" &>/dev/null; }

install_homebrew() {
  echo "Installing Homebrew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/usr/local/bin/brew shellenv)"
}

install_homebrew_tools() {
  count_apps=${#BREW_APPS[*]}
  count_packages=${#BREW_PACKAGES[*]}

  if [ "$count_apps" -eq 0 ]; then
    echo "No Homebrew applications specified for installation."
  fi

  echo "Installing Homebrew applications..."
  for app in "${BREW_APPS[@]}"; do
    if brew list --cask | grep "$app" &>/dev/null; then
      echo "$app is already installed. Skipping."
    else
      brew install --cask "$app"
    fi
  done 

  if [ "$count_packages" -eq 0 ]; then
    echo "No Homebrew package specified for installation."
  fi

  echo "Installing Homebrew packages..."
  for package in "${BREW_PACKAGES[@]}"; do
    if brew list --formula | grep "$package" &>/dev/null; then
      echo "$package is already installed. Skipping."
    else
      brew install "$package"
    fi
  done 
}

link_dotfiles() {
  echo "Removing existing configs..."
  rm -rf "$HOME/.config/nvim"
  rm -rf "$HOME/.config/alacritty"
  rm -rf "$HOME/.tmux.conf"
  rm -rf "$HOME/.zshrc"

  echo "Linking dotfiles"
  ln -s "$(pwd)/.zshrc" ~/.zshrc
  ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
  ln -s "$(pwd)/nvim" ~/.config/nvim
  ln -s "$(pwd)/alacritty" ~/.config/alacritty
}

setup_macos() {
  if [[ $OSTYPE != darwin* ]]; then
    return
  fi

  if ! is_had "brew"; then
    install_homebrew
  fi

  install_homebrew_tools
  link_dotfiles
}

setup_macos
