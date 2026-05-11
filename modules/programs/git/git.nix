{
  flake.modules.homeManager.git = {
    programs.git = {
        enable = true;

        signing = {
          format = "ssh";
          key = "~/.ssh/id_ed25519.pub";
        };

        ignores = [
          ".DS_Store"
          ".cache/"
          ".direnv/"
          ".envrc"
          ".exrc"
          ".gitlab-ci-local"
          ".luarc.json"
          ".nvmrc"
          ".python-version"
          ".rsyncrc"
          "__pycache__"
          "compile_commands.json"
        ];
      };
    };
}
