#!/usr/local/bin/zsh

target_path=$HOME
target_files=("Brewfile")

for target_file in ${target_files[@]}; do
    rm -rf $target_path/$target_file 
    ln -sv $(pwd)/$target_file $target_path/$target_file
done
