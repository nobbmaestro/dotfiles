#!/usr/local/bin/zsh

target_path=$HOME
target_files=(".zshrc" ".zsh_profile" ".zsh_aliases", ".zsh_functions", "p10k.zsh")

for target_file in ${target_files[@]}; do
    rm -rf $target_path/$target_file 
    ln -sv $(pwd)/$target_file $target_path/$target_file
done
