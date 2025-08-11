#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# List of files/folders to symlink
LINKS=(
  ".zshrc"
  ".p10k.zsh"
  ".fehbg"
  ".xinitrc"
  ".vimrc"
  ".xsession"
  ".config/bin"
  ".config/gtk-2.0"
  ".config/gtk-3.0"
  ".config/gtk-4.0"
  ".config/mpv"
  ".config/picom"
  ".config/systemd"
  ".config/wal"
  ".config/yt-dlp"
)

# Create backups and symlinks
echo ">>> Creating symlinks..."
mkdir -p "$BACKUP_DIR"
for item in "${LINKS[@]}"; do
    src="$DOTFILES_DIR/$item"
    dest="$HOME/$item"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up $dest → $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "Linking $src → $dest"
    ln -s "$src" "$dest"
done

# Build and install suckless programs
echo ">>> Building suckless software..."
for prog in dwm st dmenu dwmblocks; do
    if [ -d "$DOTFILES_DIR/$prog" ]; then
        echo "Installing $prog..."
        (cd "$DOTFILES_DIR/$prog" && make clean install)
    fi
done

echo ">>> Done! Backup stored in $BACKUP_DIR"

