if ! dnf list --installed | grep -q "swww"; then
    echo "swww not installed. Installing"
    sudo dnf install -y swww
fi

echo "Wallpapers Cycling!"

INTERVAL=30m
WALLPAPERS_DIR="$HOME/.config/hypr/wallpapers"

while true; do
    WALLPAPER=$(find "$WALLPAPERS_DIR" -type f -iname "*.jpg" -o -iname "*.png" | shuf -n 1)
    echo "WHattt $WALLPAPER"
    swww img "$WALLPAPER" --transition-step 20
    sleep $INTERVAL
done
