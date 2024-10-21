{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.eza
    pkgs.fzf
    pkgs.iterm2 # FIXME: Remove this...
    pkgs.kitty
    pkgs.lazygit
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
}
