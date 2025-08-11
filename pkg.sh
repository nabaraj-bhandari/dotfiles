#!/bin/bash
# Arch Linux setup: oh-my-zsh + yay + dwm suite + fonts + pywal

set -e  # Exit on error

# --- Install zsh ---
if ! command -v zsh >/dev/null 2>&1; then
    echo "Installing zsh..."
    sudo pacman -S --needed --noconfirm zsh
fi

# --- Backup existing .zshrc ---
if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# --- Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    export RUNZSH=no
    export CHSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- Install yay (AUR helper) ---
if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
fi

# --- Install packages ---
echo "Installing dwm, dmenu, st, dwmblocks, powerlevel10k, pywal, and fonts..."
yay -S --needed --noconfirm \
    dwm \
    dmenu \
    st \
    dwmblocks \
    zsh-theme-powerlevel10k \
    ttf-jetbrains-mono \
    noto-fonts-emoji \
    noto-fonts-cjk \
    pywal

# --- Set Zsh as default shell ---
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
fi

echo
echo "✅ Setup complete!"
echo "➡ Launch zsh with: zsh"
echo "⚙ Run 'p10k configure' to configure Powerlevel10k."
echo "🎨 Run 'wal -i /path/to/image' to apply a color scheme."

