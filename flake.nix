{
  description = "Nobbmaestros nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.eza
            pkgs.fzf
            pkgs.git
            pkgs.kitty
            pkgs.lazygit
            pkgs.neovim
            pkgs.nixfmt
            pkgs.obsidian
            pkgs.starship
            pkgs.stow
            pkgs.tmux
            pkgs.zoxide
            pkgs.zsh
            pkgs.zsh-autosuggestions
            pkgs.zsh-syntax-highlighting
            pkgs.zsh-vi-mode
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            nerd-fonts.symbols-only
            jetbrains-mono
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.primaryUser = "norbertbatiuk";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Norberts-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "norbertbatiuk";

              autoMigrate = true;
            };
          }
        ];
      };
    };
}
