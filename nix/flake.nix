{
  description = "Nobbamestro Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
            pkgs.iterm2 # FIXME: Remove this...
            pkgs.kitty
            pkgs.lazygit
            pkgs.make
            pkgs.mkalias
            pkgs.neovim
            pkgs.nixfmt-rfc-style
            pkgs.starship
            pkgs.stow
            pkgs.tmux
            pkgs.zoxide
            pkgs.zsh
            pkgs.zsh-autosuggestions
            pkgs.zsh-syntax-highlighting
            pkgs.zsh-vi-mode
          ];

          homebrew = {
            enable = true;
            onActivation = {
              cleanup = "zap"; # This will remove unspecified casks
              autoUpdate = true;
              upgrade = true;
            };
            brews = [
              "mas"
            ];
            casks = [
              "nikitabobko/tap/aerospace"
              "firefox"
              "the-unarchiver"
            ];
            masApps = { };
          };

          fonts.packages = [
            (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
          ];

          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
              # Set up applications.
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read src; do
              	app_name=$(basename "$src")
              	echo "copying $src" >&2
              	${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';

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

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true; # default shell on catalina
          # programs.fish.enable = true;

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
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "norbertbatiuk";

              # autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook-pro".pkgs;
    };
}
