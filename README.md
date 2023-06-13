# Nobbmaestro's dotfiles

Dotfiles and automations that should (theoratically alteast) make my life easier.

- [Homebrew]() The Missing Package Manager for MacOS (or Linux).
- [Neovim]() A Modern, ground up rewrite of Vim.
- [Tmux]() Create, split, save, move terminal tabs easily all within one window.
- [Zsh]()
- [PowerLevel10k]() A zsh theme that emphasizes speed, flexibility and an out-of-box experience.
- [Amethyst]() Automatic tiling window manager for MacOS.

## Getting started

Check out `./install.sh`. You may either run `./install.sh all` or pick whatever you find interesting.

The script won't run anything unless argument is passed. Once you pass decired argument, the `install.sh` will override your local dotfiles.
Therefore, you may consider running `./install backup` prior to installment, which in turn shall create a copy of all conflicting dotfiles at `~/dotfiles-backup/`.

- Install Homebrew & dependencies
- Install Xcode and CLI components
- Setup symlinks and config
