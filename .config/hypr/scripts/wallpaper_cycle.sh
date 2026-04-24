#!/bin/zsh
echo "Wallpapers Cycling!"

INTERVAL=30m
WALLPAPERS_DIR="$HOME/.config/hypr/wallpapers"

while true; do
    WALLPAPER=$(find "$WALLPAPERS_DIR" -type f -iname "*.png" | shuf -n 1)
    cp $WALLPAPER $WALLPAPERS_DIR/current.png
    awww img "$WALLPAPERS_DIR/current.png" --transition-step 20
    sleep $INTERVAL
done
