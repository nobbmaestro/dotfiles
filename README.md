# Nobbmaestro's dotfiles

Dotfiles and automations that should make my life easier (or rather harder?).

-   [Amethyst](https://github.com/ianyh/Amethyst) Automatic tiling window manager for MacOS.
-   [Homebrew](https://github.com/Homebrew/brew) The Missing Package Manager for MacOS (or Linux).
-   [Neovim](https://github.com/neovim/neovim) A Modern, ground up rewrite of Vim.
-   [Oh-My-Zsh](https://www.zsh.org) Oh My Zsh is an open source, community-driven framework for managing your zsh configuration.
-   [PowerLevel10k](https://github.com/romkatv/powerlevel10k) A zsh theme that emphasizes speed, flexibility and an out-of-box experience.
-   [Tmux](https://github.com/tmux/tmux) Create, split, save, move terminal tabs easily all within one window.
-   [Zsh](https://www.zsh.org) Zsh is a shell designed for interactive use, although it is also a powerful scripting language.

## Getting started

Check out [install.sh](install.sh). You may either run `./install.sh all` or pick whatever you find interesting.

The script won't run anything unless argument is passed. Once you pass decired argument, the `install.sh` will override your local dotfiles.
Therefore, you may consider running `./install backup` prior to installment, which in turn shall create a copy of all conflicting dotfiles at `~/dotfiles-backup/`.

The script will:

-   install Homebrew & dependencies,
-   install Xcode and CLI components,
-   setup symlinks for various configuration files, etc.

## Final words

This very repository is primarily intended to be used on MacOS, hence, the heavy dependence on Homebrew. However, it shall work just fine on any Unix distro.

Enjoy!
