icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
icon_idx=$(($(cat /sys/class/power_supply/BAT0/capacity) / 10))
battery_icon=${icons[icon_idx]}

charging=0
[[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]] && charging=1

if (( $charging )); then
    battery_icon="󰂄"
fi

echo "$battery_icon"
