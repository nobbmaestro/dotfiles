{
  description = "Nobbmaestros nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
      nix-homebrew,
      home-manager,
    }:
    let
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

          fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
            nerd-fonts.symbols-only
            jetbrains-mono
          ];

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

          ./modules/darwin/packages.nix
          ./modules/darwin/homebrew.nix
          ./modules/darwin/zsh.nix

          # nix-homebrew config
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "norbertbatiuk";
              autoMigrate = true;
            };
          }

          # home-manager config for per-user defaults
          (
            { pkgs, ... }:
            let
              nvimLangTools = with pkgs; {
                bash = [
                  shellcheck
                  shfmt
                ];
                c = [
                  clang-tools
                ];
                go = [
                  gopls
                ];
                nix = [
                  nil
                  nixfmt
                ];
                py = [
                  pyright
                  ruff
                ];
                lua = [
                  lua-language-server
                  stylua
                ];
              };

              mkUser = username: {
                home.username = username;
                home.stateVersion = "24.11";
                targets.darwin.defaults = sharedUserDefaults;

                home.file = {
                  ".config/aerospace" = {
                    source = ./config/aerospace;
                    recursive = true;
                  };

                  ".config/direnv" = {
                    source = ./config/direnv;
                    recursive = true;
                  };

                  ".config/git" = {
                    source = ./config/git;
                    recursive = true;
                  };

                  ".config/lazygit" = {
                    source = ./config/lazygit;
                    recursive = true;
                  };

                  ".config/lazyhis" = {
                    source = ./config/lazyhis;
                    recursive = true;
                  };

                  ".config/nvim" = {
                    source = ./config/nvim;
                    recursive = true;
                  }; # FIXME: LazyNvim breaks due to read-only permissions

                  ".config/starship" = {
                    source = ./config/starship;
                    recursive = true;
                  };

                  ".config/tmux" = {
                    source = ./config/tmux;
                    recursive = true;
                  };

                  ".config/yazi" = {
                    source = ./config/yazi;
                    recursive = true;
                  };

                  ".config/zsh" = {
                    source = ./config/zsh;
                    recursive = true;
                  };

                  ".zshenv" = {
                    source = ./config/zsh/.zshenv;
                  };

                  ".local/bin" = {
                    source = ./bin;
                    recursive = true;
                  };
                };

                home.packages = [ ];

                programs.neovim = {
                  enable = true;
                  extraPackages = builtins.concatLists (builtins.attrValues nvimLangTools);
                };
              };
            in
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.norbertbatiuk = mkUser "norbertbatiuk";
              home-manager.users.work = mkUser "work";
            }
          )
        ];
      };
    };
}
