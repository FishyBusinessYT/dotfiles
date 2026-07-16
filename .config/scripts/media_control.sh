#!/bin/zsh

AUDIO_NOTIF_ID=9992  # Use a fixed ID so that notifications replace one another
TIMEOUT_MS=1000  # Timeout for media control notifications
INCREMENT=5%  # Increment for volume and brightness control
ICONS_DIR=$HOME/.config/scripts/notif-icons

# The first argument to this script dictates what it should do
case $1 in
    vol_up) # Every case is pretty much the same:
        # Run operation
        wpctl set-volume -l 1 @DEFAULT_SINK@ $INCREMENT+

        # Get resulting value
        volume=$(($(wpctl get-volume @DEFAULT_SINK@ | grep -Eo '[0-9]\.[0-9]*') * 100))

        # Show mute icon if audio is muted
        isMuted=$(wpctl get-volume @DEFAULT_SINK@ | grep -c MUTE)
        icon=$ICONS_DIR/volume-high.png
        if ((isMuted==1)); then
            icon=$ICONS_DIR/volume-mute.png
        fi

        # Send notification
        notify-send -t $TIMEOUT_MS 'Volume increased' -h int:value:$volume -i $icon -r $AUDIO_NOTIF_ID
        ;;
    vol_down)
        wpctl set-volume @DEFAULT_SINK@ $INCREMENT-

        volume=$(($(wpctl get-volume @DEFAULT_SINK@ | grep -Eo '[0-9]\.[0-9]*') * 100))

        isMuted=$(wpctl get-volume @DEFAULT_SINK@ | grep -c MUTE)
        icon=$ICONS_DIR/volume-low.png
        if ((isMuted==1)); then
            icon=$ICONS_DIR/volume-mute.png
        fi

        notify-send -t $TIMEOUT_MS 'Volume lowered' -h int:value:$volume -i $icon -r $AUDIO_NOTIF_ID
        ;;
    vol_mute)
        wpctl set-mute @DEFAULT_SINK@ toggle
        isMuted=$(wpctl get-volume @DEFAULT_SINK@ | grep -c MUTE)

        if ((isMuted==1)); then
            notify-send -t $TIMEOUT_MS 'Audio muted' -i $ICONS_DIR/volume-mute.png -r $AUDIO_NOTIF_ID
        else
            notify-send -t $TIMEOUT_MS 'Audio unmuted' -i $ICONS_DIR/volume-high.png -r $AUDIO_NOTIF_ID
        fi
        ;;
    mic_mute)
        wpctl set-mute @DEFAULT_SOURCE@ toggle
        isMuted=$(wpctl get-volume @DEFAULT_SOURCE@ | grep -c MUTE)

        if ((isMuted==1)); then
            notify-send -t $TIMEOUT_MS 'Microphone muted' -i $ICONS_DIR/mic-off.png -r $AUDIO_NOTIF_ID
        else
            notify-send -t $TIMEOUT_MS 'Microphone unmuted' -i $ICONS_DIR/mic.png -r $AUDIO_NOTIF_ID
        fi
        ;;
    brightness_up)
        brightnessctl s $INCREMENT+
        brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))

        notify-send -t $TIMEOUT_MS 'Brightness increased' -h int:value:$brightness -i $ICONS_DIR/sunny-outline.png -r $AUDIO_NOTIF_ID
        ;;
    brightness_down)
        brightnessctl s $INCREMENT-
        brightness=$(($(brightnessctl g) * 100 / $(brightnessctl m)))

        notify-send -t $TIMEOUT_MS 'Brightness decreased' -h int:value:$brightness -i $ICONS_DIR/sunny-outline.png -r $AUDIO_NOTIF_ID
        ;;
    play_pause)
        playerctl play-pause
        playing=$(
            playerctl status |
            grep -cE 'Playing'  # 1 if command outputs 'Playing', 0 otherwise
        )

        if ((playing==1)); then
            notify-send -t $TIMEOUT_MS 'Player resumed' -i $ICONS_DIR/play.png -r $AUDIO_NOTIF_ID
        else
            notify-send -t $TIMEOUT_MS 'Player paused' -i $ICONS_DIR/pause.png -r $AUDIO_NOTIF_ID
        fi

        ;;
esac
