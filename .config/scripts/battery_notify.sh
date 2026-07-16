#!/bin/zsh

BATTERY_NOTIF_ID=9991  # Use a fixed ID so that notifications replace one another
ICONS_DIR=$HOME/.config/scripts/notif-icons
INTERVAL_SECONDS=15  # Delay between checks

# These files are used to check wether the notification has already been emitted.
FULL_LEVEL=80
FULL_FILE=/tmp/batteryfullnotif

WARN_LEVEL=20
WARN_FILE=/tmp/batterywarnnotif

CRIT_LEVEL=5
CRIT_FILE=/tmp/batterycritnotif

# Delete all leftover files on script startup
rm $FULL_FILE $WARN_FILE $CRIT_FILE

while true; do
    DISCHARGING=$(
        upower -i /org/freedesktop/UPower/devices/battery_BAT0 |  # Get battery info
        grep -cE 'state.*discharging'  # 1 if battery discharging, 0 otherwise
    )
    CURRENT_LEVEL=$(
        upower -i /org/freedesktop/UPower/devices/battery_BAT0 |
        grep 'percentage' |  # Grep battery percentage line
        grep -Eo '[0-9]*'  # Take the actual numeric percentage from there
    )

    # Reset crit notification if device is charging
    if [ -f "$CRIT_FILE" ] && [ "$DISCHARGING" -eq 0 ]; then
        rm "$CRIT_FILE"
    fi
    # Reset warn notification if device is charging
    if [ -f "$WARN_FILE" ] && [ "$DISCHARGING" -eq 0 ]; then
        rm "$WARN_FILE"
    fi
    # Reset full notification if device is discharging
    if [ -f "$FULL_FILE" ] && [ "$DISCHARGING" -eq 1 ]; then
        rm "$FULL_FILE"
    fi

    # If over the full threshold, charging, and the full notification hasn't been emitted, do so.
    if [ "$CURRENT_LEVEL" -gt "$FULL_LEVEL" ] && [ "$DISCHARGING" -eq 0 ] && [ ! -f "$FULL_FILE" ]; then
        notify-send \
            'Battery charged'\
            'Battery over 80%: Unplug to preserve battery life.'\
            -i $ICONS_DIR/battery-charging.png \
            -r $BATTERY_NOTIF_ID
        touch "$FULL_FILE"
    # If under the warn threshold, discharging, and the warn notification hasn't been emitted, do so.
    elif [ "$CURRENT_LEVEL" -le "$WARN_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$WARN_FILE" ]; then
        notify-send\
            'Battery low'\
            'Battery under 20%: Consider plugging in and/or turning off the system.'\
            -u normal -i $ICONS_DIR/battery-20.png \
            -r $BATTERY_NOTIF_ID
        touch "$WARN_FILE"
    # If under the crit threshold, discharging, and the crit notification hasn't been emitted, do so.
    elif [ "$CURRENT_LEVEL" -le "$CRIT_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$CRIT_FILE" ]; then
        notify-send\
            'Battery critically low'\
            'Battery under 5%: SAVE YOUR WORK IMMEDIATELY.'\
            -u critical -i $ICONS_DIR/battery-alert.png \
            -r $BATTERY_NOTIF_ID
        touch "$CRIT_FILE"
    fi

    sleep "$INTERVAL_SECONDS"
done
