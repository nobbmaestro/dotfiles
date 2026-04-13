{ pkgs, ... }:
{
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

  system.primaryUser = "norbertbatiuk";
}
