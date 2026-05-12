{
  flake.modules.homeManager.nvim =
    {
      pkgs,
      config,
      ...
    }:
    let
      nvimLangTools = with pkgs; [
        # bash
        bash-language-server
        shellcheck
        shfmt

        # clang
        clang-tools

        # golang
        gopls

        # nix
        nil
        nixfmt

        # python
        pyright
        ruff

        # lua
        lua-language-server
        stylua

        # javascript
        prettier
      ];

      rsyncer = pkgs.writeShellApplication {
        name = "rsyncer";
        runtimeInputs = with pkgs; [
          rsync
          sshpass
        ];
        text = builtins.readFile ./bin/rsyncer;
      };
    in
    {
      home.packages = [
        rsyncer
      ];

      programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;

        extraPackages = nvimLangTools;
        withPython3 = true;
        withRuby = true;
      };

      programs.zsh.initContent = ''
        function nvim() {
          local socket="/tmp/nvim-server-$(tmux display-message -p '#S').sock"
          if [[ ! -S "$socket" ]]; then
            command nvim --listen "$socket" "$@"
          else
            command nvim "$@"
          fi
        }
      '';

      home.file = {
        ".config/nvim" = {
          source = ./src;
          recursive = true;
        }; # FIXME: LazyVim breaks due to read-only permissions
      };
    };
}
