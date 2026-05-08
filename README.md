# Nobbmaestro's dotfiles

[![macOS Build](https://github.com/nobbmaestro/dotfiles/actions/workflows/build.yml/badge.svg)](https://github.com/nobbmaestro/dotfiles/actions/workflows/build.yml)

My macOS development environment, now fully managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin).

This repository defines a **reproducible, declarative macOS system configuration** using Nix flakes.

## What's included

### System (nix-darwin)

- macOS defaults
- system-level packages
- shell configuration

### Development tools

- Neovim
- Git + LazyGit
- Tmux
- Starship prompt
- Zsh environment

### Window management

- AeroSpace (i3-like tiling WM for macOS)

### Package management

- Nix
- Homebrew

## Getting started

### 1. Install nix

Install nix from the offical installer:

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

or, simply run:

```sh
make install
```

### 2. Build the system

Following command will build and apply the full macOS configuration using nix-darwin:

```sh
make switch
```

This is equivalent to:

```sh
darwin-rebuild switch --flake .#<hostname>
```

The hostname must match a valid configuration in `flake.nix`.

## Resources

[Dendritic Nix](https://dendrix.oeiuwq.com/Dendritic.html)
[Dendritic Design with the Flake Parts Framework](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
[Set up Nix on macOS using flakes, nix-darwin and home-manager](https://noghartt.dev/blog/set-up-nix-on-macos-using-flakes-nix-darwin-and-home-manager/)
[Ultimate NixOS Desktop: Niri, Noctalia Shell, and the Dendritic Pattern | Full Setup](https://www.youtube.com/watch?v=aNgujRXDTdE)
[NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world)

## Final Words

This very repository is intended for **_my personal usage_**. Breaking changes, change of utilities, or pattern may occur at any point.

Enjoy!
