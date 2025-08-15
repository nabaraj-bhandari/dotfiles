#!/bin/bash
# ~/config/bin/media-play.sh

# First prompt for mode
mode=$(printf "Music All\nVideo All\nSearch Music\nSearch Video" | dmenu -i -p "Choose mode:")

[[ -z "$mode" ]] && exit 0

if [[ "$mode" == "Music All" ]]; then
    # Find all media files in Music + Videos
    mapfile -t files < <(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.mkv" \))
    [[ ${#files[@]} -eq 0 ]] && { echo "No media files found"; exit 1; }
    mpv --cover-art-auto=all "${files[@]}" --vid=2
elif [[ "$mode" == "Video All" ]]; then
    # Find all media files in Music + Videos
    mapfile -t files < <(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.mkv" \))
    [[ ${#files[@]} -eq 0 ]] && { echo "No media files found"; exit 1; }
    mpv --cover-art-auto=all "${files[@]}"
elif [[ "$mode" == "Search Music" ]]; then
    # Search mode: choose single file with dmenu (show paths relative to $HOME)
    choice=$(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" \) \
        | sed "s#^$HOME##" \
        | dmenu -i -p "Select music:")
    [[ -z "$choice" ]] && exit 0
    mpv --cover-art-auto=all "$HOME$choice" --vid=2
else
    # Search mode: choose single file with dmenu (show paths relative to $HOME)
    choice=$(find ~/Music ~/Videos -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.webm" -o -iname "*.mkv" \) \
        | sed "s#^$HOME##" \
        | dmenu -i -p "Select video:")
    [[ -z "$choice" ]] && exit 0
    mpv --cover-art-auto=all "$HOME$choice"
fi


