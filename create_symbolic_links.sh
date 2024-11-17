#!/bin/bash

CONFIG_DIR="$HOME/.config"
PROJECT_DIR="/home/juan/devel/dotfiles"

for dir in "$PROJECT_DIR"/*/; do
    dir_name=$(basename "$dir")
    target="$CONFIG_DIR/$dir_name"
    if [ ! -e "$target" ]; then
        ln -s "$dir" "$target"
        echo "Created symlink for $dir_name"
    else
        echo "Symlink for $dir_name already exists, skipping..."
    fi
done