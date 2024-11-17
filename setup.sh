#!/bin/bash

# create symbolic links for missing folders

CONFIG_DIR="$HOME/.config"
PROJECT_DIR="/home/juan/devel/dotfiles"

for dir in "$PROJECT_DIR"/*/; do
    dir_name=$(basename "$dir")
    target="$CONFIG_DIR/$dir_name"
    if [ ! -e "$target" ]; then
        ln -s "$dir" "$target"
        echo "Created symlink for $dir_name"
    else
        echo "Symlink for $dir_name already exists, do you want to overwrite it? [y/N]"
        read -r response
        if [[ "$response" == [yY] ]]; then
            ln -sf "$dir" "$target"
            echo "Overwrote symlink for $dir_name"
        else
            echo "Skipped symlink for $dir_name"
        fi
    fi
done