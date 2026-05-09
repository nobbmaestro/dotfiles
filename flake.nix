{
  description = "Nobbmaestro's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.brew-api.follows = "brew-api";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
