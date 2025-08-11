#!/bin/bash

DMENU="dmenu -i -l 15 -p"
DOWNLOAD_DIR="$HOME/Videos"

# Ask for search term
QUERY=$(printf "" | $DMENU "Search YouTube:")
[ -z "$QUERY" ] && exit

# Get top 15 search results (title + URL)
RESULTS=$(yt-dlp "ytsearch15:$QUERY" --get-title --get-id | \
    awk 'NR%2{title=$0;next}{print title " | https://youtu.be/" $0}' )

[ -z "$RESULTS" ] && exit

# Let user pick video
CHOICE=$(echo "$RESULTS" | $DMENU "Select video:")
[ -z "$CHOICE" ] && exit

URL=$(echo "$CHOICE" | awk -F' | ' '{print $NF}')

# Action menu
ACTION=$(printf "Play\nDownload" | $DMENU "Action:")
[ -z "$ACTION" ] && exit

if [ "$ACTION" = "Play" ]; then
    mpv --no-terminal "$URL"
else
    mkdir -p "$DOWNLOAD_DIR"
    yt-dlp -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" "$URL"
    notify-send "Download Complete" "$CHOICE"
fi

