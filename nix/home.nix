{ config, pkgs, ... }:
{
  home.stateVersion = "24.11";

  home.file = {
    ".zshrc".source = ~/dotfiles/.zshrc;
    ".tmux.conf".source = ~/dotfiles/.tmux.conf;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/alacritty".source = ~/dotfiles/alacritty;
  };
}
