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

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

or

```sh
make install
```

### 2. Build the system

```sh
make build
```

This runs:

```sh
darwin-rebuild switch --flake .#<hostname>
```

## Final Words

This very repository is intended for **_my personal usage_**. Breaking changes, change of utilities, or pattern may occur at any point.

Enjoy!
