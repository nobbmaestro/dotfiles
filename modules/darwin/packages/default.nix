{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    direnv
    eza
    fzf
    git
    gitflow
    htop
    kitty
    lazygit
    nix-direnv
    ripgrep
    sshpass
    stow
    tldr
    tmux
    yazi

    # Dev
    arduino-cli
    bear
    docker
    gcc-arm-embedded
    git-fame
    gitlab-ci-local
    picocom
    python3
    speedtest-cli
    wireshark
    uv

    # Shell
    starship
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vi-mode

    # macOS
    aerospace
    keepassxc
    lazyhis
  ];
}
