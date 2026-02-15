{
  description = "Nobbmaestros nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/e89cf1c932006531f454de7d652163a9a5c86668";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-neovim,
      nix-homebrew,
    }:
    let
      system = "aarch64-darwin";

      pinnedPkgs = import nixpkgs-neovim {
        inherit system;
        config.allowUnfree = true;
      };

      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pinnedPkgs.neovim
            pkgs.curl
            pkgs.direnv
            pkgs.eza
            pkgs.fzf
            pkgs.git
            pkgs.gitflow
            pkgs.htop
            pkgs.kitty
            pkgs.lazygit
            pkgs.nix-direnv
            pkgs.nixfmt
            pkgs.obsidian
            pkgs.ripgrep
            pkgs.sshpass
            pkgs.stow
            pkgs.tldr
            pkgs.tmux
            pkgs.yazi

            # Dev Utilities
            pkgs.arduino-cli
            pkgs.bear
            pkgs.container
            pkgs.docker
            pkgs.gcc-arm-embedded
            pkgs.gitlab-ci-local
            pkgs.picocom
            pkgs.python3
            pkgs.wireshark
            pkgs.uv

            # Shell & Prompt
            pkgs.starship
            pkgs.zoxide
            pkgs.zsh-autosuggestions
            pkgs.zsh-syntax-highlighting
            pkgs.zsh-vi-mode

            # MacOS Utilities
            pkgs.aerospace
            pkgs.aldente
            pkgs.bartender
            pkgs.monitorcontrol
            pkgs.spotify
            pkgs.the-unarchiver
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            nerd-fonts.symbols-only
            jetbrains-mono
          ];

          homebrew = {
            enable = true;
            onActivation = {
              cleanup = "zap"; # This will remove unspecified casks
              autoUpdate = true;
              upgrade = true;
            };
            brews = [
              "mole"
              "nobbmaestro/tap/lazyhis"
            ];
            casks = [
              "alfred"
              "dictionaries"
              # "docker-desktop"
              "karabiner-elements"
              "logi-options+"
              # "parallels"
              "saleae-logic"
              "segger-jlink"
              "stremio"
            ];
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.zsh = {
            enable = true;
            interactiveShellInit = ''
              source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
              source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
              source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
            '';
          };

          system.defaults = {
            dock = {
              autohide = true;
              show-recents = false;

              tilesize = 41;
              largesize = 70;
              magnification = true;
              mru-spaces = false;
            };

            finder = {
              _FXSortFoldersFirst = true;
              AppleShowAllFiles = true;
              FXPreferredViewStyle = "SCcf";
              ShowPathbar = true;
            };

            NSGlobalDomain = {
              AppleShowAllExtensions = true;
              AppleInterfaceStyle = "Dark";
              KeyRepeat = 2;
            };

            WindowManager.EnableStandardClickToShowDesktop = false;
            loginwindow.GuestEnabled = false;
          };

          # Enable TouchID authentication on sudo
          security.pam.services.sudo_local = {
            touchIdAuth = true;
            reattach = true;
          };

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
