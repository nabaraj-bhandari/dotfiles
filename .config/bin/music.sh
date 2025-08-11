#!/bin/bash

status=$(playerctl status 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

# Font Awesome icons:
icon_play=""     # \uf001
icon_pause=""    # \uf04c

if [ "$status" = "Playing" ]; then
    text="$icon_play $title"
elif [ "$status" = "Paused" ]; then
    text="$icon_pause $title"
else
    exit 0
fi

# Fake-center by adding padding (adjust manually for your screen)
echo " $text"

