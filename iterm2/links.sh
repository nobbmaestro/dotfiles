#!/usr/local/bin/zsh

target_path=$HOME"/.config/iterm2"
target_files=("com.googlecode.iterm2.plistf")

for target_file in ${target_files[@]}; do
    rm -rf $target_path/$target_file 
    ln -sv $(pwd)/$target_file $target_path/$target_file
done
