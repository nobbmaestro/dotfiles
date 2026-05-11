# Nobbmaestro's dotfiles

[![macOS Build](https://github.com/nobbmaestro/dotfiles/actions/workflows/build.yml/badge.svg)](https://github.com/nobbmaestro/dotfiles/actions/workflows/build.yml)

My macOS development environment, now fully managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin).

This repository defines a **reproducible, declarative macOS system configuration** using Nix flakes, organised with the [dendritic pattern](https://dendrix.oeiuwq.com/Dendritic.html) on top of [flake-parts](https://flake.parts/) and [import-tree](https://github.com/vic/import-tree).

## What's included

### System (nix-darwin)

Layered under `modules/system/darwin/`:

- **`0-base`** — core macOS system setup and app fixes
- **`1-shell`** — system-level shell configuration
- **`2-tools`** — system-level CLI tools
- **`3-desktop`** — desktop settings, fonts, keyboard, security, and macOS defaults

### Programs (home-manager)

Per-program modules under `modules/programs/`:

- **Editor / shell**: Neovim, Zsh, Starship, Tmux, Kitty
- **Navigation**: fzf, zoxide, yazi, eza
- **Git workflow**: Git, LazyGit, LazyDocker
- **Window management**: AeroSpace (i3-like tiling WM for macOS)
- **Dev ergonomics**: direnv, [lazyhis](https://github.com/nobbmaestro/lazyhis)

### Package management

- Nix (via flakes)
- Homebrew (via [nix-homebrew](https://github.com/zhaofengli/nix-homebrew))

## Repository layout

```
flake.nix                     # minimal entry point — imports ./modules via import-tree
modules/
├── nix/                      # flake-parts setup, home-manager & nix-homebrew integration
├── system/darwin/            # nix-darwin system layers (0-base … 3-desktop)
├── programs/                 # per-program home-manager modules
├── users/                    # per-user home-manager configs (norbertbatiuk, work)
└── hosts/                    # per-host darwin configs
    └── macbook-pro-m1/
        ├── configuration.nix # host-level config
        └── users/            # which users live on this host
```

With the dendritic pattern, every `.nix` file under `modules/` is auto-imported — there is no central import list to maintain. `flake.nix` simply hands the tree to `flake-parts`.

## Getting started

### 1. Install nix

Install nix from the official installer:

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

or, simply run:

```sh
make install
```

### 2. Build the system

The following command will build and apply the full macOS configuration using nix-darwin:

```sh
make switch
```

This defaults to the `macbook-pro-m1` host (see `HNAME` in the `Makefile`) and is equivalent to:

```sh
sudo darwin-rebuild switch --flake .#macbook-pro-m1
```

To target a different host, override `HNAME`:

```sh
make switch HNAME=<hostname>
```

The hostname must match a host defined under `modules/hosts/`.

### Other useful targets

```sh
make check     # nix flake check
make update    # nix flake update
make clean     # nix-store --gc
make uninstall # remove nix-darwin
```

## Adding a host or user

- **New host**: create `modules/hosts/<hostname>/configuration.nix` following the pattern in `macbook-pro-m1`, then add `modules/hosts/<hostname>/users/<user>.nix` binding files for each user on that host.
- **New user**: create `modules/users/<user>/` with the user's home-manager config, then bind it to one or more hosts via the `users/<user>.nix` files above.

## Resources

- [Dendritic Nix](https://dendrix.oeiuwq.com/Dendritic.html)
- [Dendritic Design with the Flake Parts Framework](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)
- [Set up Nix on macOS using flakes, nix-darwin and home-manager](https://noghartt.dev/blog/set-up-nix-on-macos-using-flakes-nix-darwin-and-home-manager/)
- [Ultimate NixOS Desktop: Niri, Noctalia Shell, and the Dendritic Pattern | Full Setup](https://www.youtube.com/watch?v=aNgujRXDTdE)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world)

## Final Words

This very repository is intended for **_my personal usage_**. Breaking changes, change of utilities, or pattern may occur at any point.

Enjoy!
