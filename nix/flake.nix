{
  description = "Lixun nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      environment.systemPackages =
        [ 
          pkgs.k9s
          pkgs.ripgrep
          pkgs.eza
          pkgs.fish
          pkgs.tree
          pkgs.awscli
          pkgs.neofetch
          pkgs.alacritty
	        pkgs.neovim
	        pkgs.tmux
        ];

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      system.defaults = {
        dock.autohide = false;
        screencapture.location = "~/Pictures/screenshots";
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.KeyRepeat = 2;
      };

      users.users.thangrangto = {
        name = "thangrangto";
        home = "/Users/thangrangto";
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using: darwin-rebuild switch --flake ~/nix#lixun --impure
    darwinConfigurations."lixun" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.thangrangto = import ./home.nix;
        }
      ];
    };
  };
}
