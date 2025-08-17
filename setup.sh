#!/bin/bash

DOTFILES_DIR=$(pwd)

FILES=".zshrc .zsh_aliases .zsh_functions"

echo "Creating dotfiles..."

for file in $FILES; do
    target="$HOME/$file"
    if [ -e "$target" ]; then
        echo "Backing up existing $file to $file.backup"
        mv "$target" "$target.backup"
    fi
    echo "Creating symlink for $file"
    ln -s "$DOTFILES_DIR/$file" "$target"
done

echo "Sourcing .zshrc..."
source "$HOME/.zshrc"

echo "Dotfiles setup complete."
