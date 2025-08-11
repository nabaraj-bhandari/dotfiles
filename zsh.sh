#!/bin/bash
# oh-my-zsh installer script

set -e  # Exit on error

# Install zsh if not installed
if ! command -v zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm zsh
    elif command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y zsh
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y zsh
    else
        echo "Unsupported package manager. Install zsh manually."
        exit 1
    fi
fi

# Backup existing .zshrc
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Install oh-my-zsh non-interactively
echo "Installing oh-my-zsh..."
export RUNZSH=no  # Don't start zsh right after install
export CHSH=no    # Don't change shell automatically
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

echo "Oh My Zsh installed successfully!"
echo "Start zsh by running: zsh"

