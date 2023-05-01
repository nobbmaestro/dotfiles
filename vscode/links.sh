#!/usr/local/bin/zsh

target_path=~/"Library/Application Support/Code/User"

rm -rf $target_path/settings.json $target_path/keybindings.json
ln -sv $(pwd)/settings.json $target_path/settings.json
ln -sv $(pwd)/keybindings.json $target_path/keybindings.json

