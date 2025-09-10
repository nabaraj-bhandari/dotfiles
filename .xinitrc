#!/bin/bash

# Start Pipewire services
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Set keyboard layout
setxkbmap us &

# Set display resolution
xrandr --output eDP-1 --mode 1920x1080 &

# Start status bar
dwmblocks &

# Compositor
~/.config/bin/wal &
picom --config ~/.config/picom/picom.conf &

# Start notification daemon
dunst &

#freebsd &

# Start ws-server
~/.dotfiles/.config/bin/ws-server &

while true; do
	dwm >/dev/null 2>&1
done

# Finally, start dwm (this will block until dwm exits)
exec dwm 
