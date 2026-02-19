{
  description = "Nobbmaestros nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/e89cf1c932006531f454de7d652163a9a5c86668";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-neovim,
      nix-homebrew,
      home-manager,
    }:
    let
      system = "aarch64-darwin";

      pinnedPkgs = import nixpkgs-neovim {
        inherit system;
        config.allowUnfree = true;
      };

      # These are per-user preferences on macOS.
      # We apply them via home-manager for EACH user.
      sharedUserDefaults = {
        NSGlobalDomain = {
          AppleShowAllExtensions = true;
          AppleInterfaceStyle = "Dark";
          KeyRepeat = 2;
        };

        "com.apple.dock" = {
          autohide = true;
          "show-recents" = false;

          tilesize = 41;
          largesize = 70;
          magnification = true;
          "mru-spaces" = false;
        };

        "com.apple.finder" = {
          _FXSortFoldersFirst = true;
          AppleShowAllFiles = true;
          FXPreferredViewStyle = "SCcf";
          ShowPathbar = true;
        };

        # WindowManager.* lives in the "com.apple.WindowManager" domain
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = false;
        };
      };

      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

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
            pkgs.ripgrep
            pkgs.sshpass
            pkgs.stow
            pkgs.tldr
            pkgs.tmux
            pkgs.yazi

            # Dev Utilities
            pkgs.arduino-cli
            pkgs.bear
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
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            nerd-fonts.symbols-only
            jetbrains-mono
          ];

          homebrew = {
            enable = true;
            onActivation = {
              cleanup = "zap";
              autoUpdate = true;
              upgrade = true;
            };
            brews = [
              "mole"
              "nobbmaestro/tap/lazyhis"
            ];
            casks = [
              "aldente"
              "alfred"
              "dictionaries"
              "logi-options+"
              "monitorcontrol"
              "obsidian"
              "saleae-logic"
              "segger-jlink"
              "spotify"
              "stremio"
              "the-unarchiver"
              "wireshark-app"
            ];
          };

          users.knownUsers = [
            "norbertbatiuk"
            "work"
          ];

          users.users.norbertbatiuk = {
            home = "/Users/norbertbatiuk";
            shell = pkgs.zsh;
            uid = 501;
          };

          users.users.work = {
            home = "/Users/work";
            shell = pkgs.zsh;
            createHome = true;
            isHidden = false;
            uid = 502;
          };

          nix.settings.experimental-features = "nix-command flakes";

          programs.zsh = {
            enable = true;
            interactiveShellInit = ''
              source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
              source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
              source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
            '';
          };

          system = {
            # Keep ONLY truly system-wide defaults here.
            defaults = {
              loginwindow.GuestEnabled = false;
            };

            keyboard = {
              enableKeyMapping = true;
              remapCapsLockToControl = true;
            };
          };

          security.pam.services.sudo_local = {
            touchIdAuth = true;
            reattach = true;
          };

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.primaryUser = "norbertbatiuk";
        };
    in
    {
      darwinConfigurations."Norberts-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration

          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          # nix-homebrew config
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = false;
              user = "norbertbatiuk";
              autoMigrate = true;
            };
          }

          # home-manager config for per-user defaults
          (
            { pkgs, ... }:
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.norbertbatiuk = {
                home.username = "norbertbatiuk";
                home.stateVersion = "24.11";
                targets.darwin.defaults = sharedUserDefaults;

                home.packages = [ ];
              };

              home-manager.users.work = {
                home.username = "work";
                home.stateVersion = "24.11";
                targets.darwin.defaults = sharedUserDefaults;

                home.packages = [ ];
              };
            }
          )
        ];
      };
    };
}
