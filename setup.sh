#!/bin/bash

DOTFILES_DIR=$(pwd)
FILES=".zshrc .zsh_aliases .zsh_functions"

# ---------------------------
# 1. Install Zsh if missing
# ---------------------------
if ! command -v zsh &> /dev/null; then
    echo "Zsh not found. Installing Zsh..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v pacman &> /dev/null; then
            sudo pacman -Syu --noconfirm zsh
        elif command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y zsh
        elif command -v yum &> /dev/null; then
            sudo yum install -y zsh
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    else
        echo "Unsupported OS. Please install Zsh manually."
        exit 1
    fi
fi

# ---------------------------
# 2. Install Oh My Zsh if missing
# ---------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh not found. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ---------------------------
# 3. Symlink dotfiles (idempotent + auto-update)
# ---------------------------
echo "Setting up dotfiles..."

for file in $FILES; do
    target="$HOME/$file"
    source="$DOTFILES_DIR/$file"

    # If target is a symlink pointing elsewhere or missing, recreate it
    if [ -L "$target" ]; then
        if [ "$(readlink "$target")" != "$source" ]; then
            echo "Updating symlink for $file"
            rm "$target"
            ln -s "$source" "$target"
        else
            echo "Symlink for $file already correct. Skipping."
        fi
    # If target is a real file, back it up once and create symlink
    elif [ -e "$target" ]; then
        if [ ! -e "$target.backup" ]; then
            echo "Backing up existing $file to $file.backup"
            mv "$target" "$target.backup"
        else
            echo "Backup for $file already exists. Skipping backup."
        fi
        echo "Creating symlink for $file"
        ln -s "$source" "$target"
    # If target doesn't exist, just create symlink
    else
        echo "Creating symlink for $file"
        ln -s "$source" "$target"
    fi
done

# ---------------------------
# 4. Set Zsh as default shell
# ---------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s "$(which zsh)"
fi

echo "Sourcing .zshrc..."
source "$HOME/.zshrc"

echo "Dotfiles setup complete! Please restart your terminal to use Zsh as your default shell."
