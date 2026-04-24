#!/bin/zsh

BATTERY_NOTIF_ID=9991
ICONS_DIR=$HOME/.config/hypr/icons
INTERVAL=15

FULL_LEVEL=80
FULL_FILE=/tmp/batteryfullnotif

WARN_LEVEL=20
WARN_FILE=/tmp/batterywarnnotif

CRIT_LEVEL=5
CRIT_FILE=/tmp/batterycritnotif

while true; do
    DISCHARGING=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -cE 'state.*discharging')
    CURRENT_LEVEL=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | grep -Eo '[0-9]*')

    if [ -f "$CRIT_FILE" ] && [ "$DISCHARGING" -eq 0 ]; then
        rm "$CRIT_FILE"
    fi
    if [ -f "$WARN_FILE" ] && [ "$DISCHARGING" -eq 0 ]; then
        rm "$WARN_FILE"
    fi
    if [ -f "$FULL_FILE" ] && [ "$DISCHARGING" -eq 1 ]; then
        rm "$FULL_FILE"
    fi

    if [ "$CURRENT_LEVEL" -gt "$FULL_LEVEL" ] && [ "$DISCHARGING" -eq 0 ] && [ ! -f "$FULL_FILE" ]; then
        notify-send \
            'Battery charged'\
            'Battery over 80%: Unplug to preserve battery life.'\
            -i $ICONS_DIR/battery-charging.png \
            -r $BATTERY_NOTIF_ID
        touch "$FULL_FILE"
    elif [ "$CURRENT_LEVEL" -le "$WARN_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$WARN_FILE" ]; then
        notify-send\
            'Battery low'\
            'Battery under 20%: Consider plugging in and/or turning off the system.'\
            -u normal -i $ICONS_DIR/battery-20.png \
            -r $BATTERY_NOTIF_ID
        touch "$WARN_FILE"
    elif [ "$CURRENT_LEVEL" -le "$CRIT_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$CRIT_FILE" ]; then
        notify-send\
            'Battery critically low'\
            'Battery under 5%: SAVE YOUR WORK IMMEDIATELY.'\
            -u critical -i $ICONS_DIR/battery-alert.png \
            -r $BATTERY_NOTIF_ID
        touch "$CRIT_FILE"
    fi

    sleep "$INTERVAL"
done
