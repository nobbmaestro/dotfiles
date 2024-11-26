# Nobbmaestro's dotfiles

Dotfiles and automations that should make my life easier (or rather harder?).

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) AeroSpace is an i3-like tiling window manager for macOS
- [Homebrew](https://github.com/Homebrew/brew) The Missing Package Manager for MacOS (or Linux).
- [Neovim](https://github.com/neovim/neovim) A Modern, ground up rewrite of Vim.
- [Starship](https://github.com/starship/starship) The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- [Tmux](https://github.com/tmux/tmux) Create, split, save, move terminal tabs easily all within one window.
- [Zsh](https://www.zsh.org) Zsh is a shell designed for interactive use, although it is also a powerful scripting language.

## Getting started

### Bootstrap

Check out [install.sh](install.sh). You may either run `./resources/install.sh all` or pick whatever you find interesting.

The script won't run anything unless argument is passed. Once you pass decired argument, the `install.sh` execute associated function.

The `./resources/install.sh all` command will:

- install Homebrew & dependencies,
- install Xcode and CLI components,
- install Tmux [tpm](https://github.com/tmux-plugins/tpm) and plugins
- and more

### Stow dotfiles

Symlinks are managed by [gnu-stow](https://www.gnu.org/software/stow/). To initialize gnu-stow, simply run

```sh
make all
```

## Final Words

This very repository is intended for **_my personal usage_**. Breaking changes, change of utilities, or pattern may accure at any point.

Enjoy!
