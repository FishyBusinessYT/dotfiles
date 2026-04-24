#!/bin/zsh

AUDIO_NOTIF_ID=9992
TIMEOUT=1000
INCREMENT=5%
ICONS_DIR=$HOME/.config/hypr/icons/

case $1 in
    vol_up)
        wpctl set-volume -l 1 @DEFAULT_SINK@ $INCREMENT+
        volume=$(($(wpctl get-volume @DEFAULT_SINK@ | grep -Eo '[0-9]\.[0-9]*') * 100))

        notify-send -t $TIMEOUT 'Volume increased' -h int:value:$volume -i $ICONS_DIR/volume-high.png -r $AUDIO_NOTIF_ID
        ;;
    vol_down)
        wpctl set-volume @DEFAULT_SINK@ $INCREMENT-
        volume=$(($(wpctl get-volume @DEFAULT_SINK@ | grep -Eo '[0-9]\.[0-9]*') * 100))

        notify-send -t $TIMEOUT 'Volume lowered' -h int:value:$volume -i $ICONS_DIR/volume-low.png -r $AUDIO_NOTIF_ID
        ;;
    vol_mute)
        wpctl set-mute @DEFAULT_SINK@ toggle
        isMuted=$(wpctl get-volume @DEFAULT_SINK@ | grep -c MUTE)

        if ((isMuted==1)); then
            notify-send -t $TIMEOUT 'Audio muted' -i $ICONS_DIR/volume-mute.png -r $AUDIO_NOTIF_ID
        else
            notify-send -t $TIMEOUT 'Audio unmuted' -i $ICONS_DIR/volume-high.png -r $AUDIO_NOTIF_ID
        fi
        ;;
    mic_mute)
        wpctl set-mute @DEFAULT_SOURCE@ toggle
        isMuted=$(wpctl get-volume @DEFAULT_SOURCE@ | grep -c MUTE)

        if ((isMuted==1)); then
            notify-send -t $TIMEOUT 'Microphone muted' -i $ICONS_DIR/mic-off.png -r $AUDIO_NOTIF_ID
        else
            notify-send -t $TIMEOUT 'Microphone unmuted' -i $ICONS_DIR/mic.png -r $AUDIO_NOTIF_ID
        fi
        ;;
    brightness_up)
        brightnessctl s $INCREMENT+
        brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))

        notify-send -t $TIMEOUT 'Brightness increased' -h int:value:$brightness -i $ICONS_DIR/sunny-outline.png -r $AUDIO_NOTIF_ID
        ;;
    brightness_down)
        brightnessctl s $INCREMENT-
        brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))

        notify-send -t $TIMEOUT 'Brightness decreased' -h int:value:$brightness -i $ICONS_DIR/sunny-outline.png -r $AUDIO_NOTIF_ID
        ;;
esac
