#!/bin/zsh

rm -rf ~/.zshrc ~/.zsh_profile ~/.zsh_aliases ~/.zsh_functions ~/.p10k.zsh

ln -sv $(pwd)/.zshrc ~/.zshrc
ln -sv $(pwd)/.zsh_profile ~/.zsh_profile
ln -sv $(pwd)/.zsh_aliases ~/.zsh_aliases
ln -sv $(pwd)/.zsh_functions ~/.zsh_functions
ln -sv $(pwd)/.p10k.zsh ~/.p10k.zsh
