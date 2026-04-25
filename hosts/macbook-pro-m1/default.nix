{ pkgs, ... }:
{
  imports = [
    ./../../modules/base
    ./../../modules/darwin
  ];

  networking = {
    hostName = "macbook-pro-m1";
    localHostName = "macbook-pro-m1";
  };

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

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "norbertbatiuk";
    autoMigrate = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.norbertbatiuk = import ./../../home;
    users.work = import ./../../home;
  };

  system.primaryUser = "norbertbatiuk";
}
