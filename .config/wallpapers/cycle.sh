#!/bin/zsh

INTERVAL=5m
WALLPAPERS_DIR="$HOME/.config/wallpapers"

while true; do
    WALLPAPER=$(find "$WALLPAPERS_DIR" \
        -type f -iname "*.png" \
        -not -iname "current.png" \
        | shuf -n 1
    )
    cp $WALLPAPER $WALLPAPERS_DIR/current.png
    awww img "$WALLPAPERS_DIR/current.png" \
        -t center \
        --transition-step 255 \
        --transition-fps 60
    sleep $INTERVAL
done
