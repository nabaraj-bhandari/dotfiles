#!/bin/bash
# ~/config/bin/media-play.sh

# First prompt for mode
mode=$(printf "Play All\nSearch" | dmenu -i -p "Choose mode:")

[[ -z "$mode" ]] && exit 0

if [[ "$mode" == "Play All" ]]; then
    # Find all media files in Music + Videos
    mapfile -t files < <(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.mkv" \))
    [[ ${#files[@]} -eq 0 ]] && { echo "No media files found"; exit 1; }
    mpv --cover-art-auto=all "${files[@]}"
else
    # Search mode: choose single file with dmenu (show paths relative to $HOME)
    choice=$(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" \) \
        | sed "s#^$HOME##" \
        | dmenu -i -p "Select media:")
    [[ -z "$choice" ]] && exit 0
    mpv --cover-art-auto=all "$HOME$choice"
fi

