#!/bin/bash

# Start Pipewire services
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Set keyboard layout
setxkbmap -option caps:swapescape

# Set display resolution
xrandr --output eDP-1 --mode 1920x1080 &

# Start compositor
picom --config ~/.config/picom/picom.conf &

# Start dwmblocks
dwmblocks &

# Start notification daemon
dunst &

# Set the wallpaper (note: use correct flag and path expansion)
feh --bg-fill "$HOME/.local/share/wallpapers/your-name-anime.jpg"

# Start dwm in a loop (optional - useful if dwm crashes and you want it to auto-restart)
while true; do
  dwm
done

exec dwm
