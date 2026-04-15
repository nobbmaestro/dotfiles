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
      system = "aarch64-darwin";

      mkUser = import ./modules/home/mkUser.nix;
    in
    {
      darwinConfigurations."Norberts-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager

          ./modules/darwin/packages.nix
          ./modules/darwin/homebrew.nix
          ./modules/darwin/fonts.nix
          ./modules/darwin/system.nix
          ./modules/darwin/users.nix
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
          ({
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.norbertbatiuk = mkUser "norbertbatiuk";
            home-manager.users.work = mkUser "work";
          })
        ];
      };
    };
}
