# Nix

## Commands

### Install nix-darwin

```sh
sh  <(curl -L https://nixos.org/nix/install)
```

### Build system

```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#macbook-pro
```

### Rebuild system

```sh
darwin-rebuild switch --flake ~/.config/nix#macbook-pro
```

### Update

```sh
nix flake update
```

### Darwin system configuration

```sh
man 5 configuration.nix
```

or

```sh
darwin-help
```

### Useful links

-   [Nix packages search engine](https://search.nixos.org)

-   [MyNixOS](https://mynixos.com)
