{ config, ... }:
let
  profiles = {
    norbertbatiuk = {
      name = "Norbert Batiuk";
      email = "norbert@batiuk.se";
    };
    work = {
      name = "Norbert Batiuk";
      email = "norbert.batiuk@stagesmarts.com";
    };
  };
  profile = profiles.${config.home.username};
in
{
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
    };

    settings = {
      pull.rebase = true;

      user = {
        name = profile.name;
        email = profile.email;
      };
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
}
