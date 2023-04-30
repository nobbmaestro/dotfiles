#!/usr/local/bin/zsh

rm -rf ~/.tmux.conf ~/.tmux-cht-command ~/.tmux-cht-languages
ln -sv $(pwd)/.tmux.conf ~/.tmux.conf
ln -sv $(pwd)/.tmux-cht-command ~/.tmux-cht-command
ln -sv $(pwd)/.tmux-cht-languages ~/.tmux-cht-languages

