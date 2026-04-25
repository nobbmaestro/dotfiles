{
  description = "Declarative macOS system configuration using nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    {
      darwinConfigurations = {
        macbook-pro-m1 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";

          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            ./hosts/macbook-pro-m1/default.nix
          ];
        };
      };
    };
}
