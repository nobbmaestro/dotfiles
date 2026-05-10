{
  inputs,
  ...
}:
{
  flake.modules.darwin.system-tools = {
    imports = with inputs.self.modules.darwin; [
      system-shell
    ];
  };

  flake.modules.homeManager.system-tools =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        system-shell

        direnv
        fzf
        git
        lazydocker
        lazygit
        nvim
        tmux
        yazi
      ];

      home.packages = with pkgs; [
        curl
        gitflow
        htop
        nix-direnv
        ripgrep
        tldr

        # dev
        arduino-cli
        bear
        claude-code
        docker
        git-fame
        gitlab-ci-local
        picocom
        python3
        speedtest-cli
        wireshark

        # shell
        starship
        zoxide
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-vi-mode
      ];
    };
}
