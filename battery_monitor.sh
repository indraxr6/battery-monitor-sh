#!/bin/bash

get_battery_percentage() {
    pmset -g batt | grep -Eo "\d+%" | cut -d% -f1
}

last_percentage=$(get_battery_percentage)
duration=0

while true; do
    current_percentage=$(get_battery_percentage)

    if [ "$current_percentage" -ne "$last_percentage" ]; then
        duration=0
        osascript -e 'display notification \"Battery is now $current_percentage%\" with title \"Battery Monitor\"'

    else
        duration=$((duration + 1))
    fi

    echo "Current Battery: $current_percentage% - Duration: $duration minute(s)"

    sleep 60  # Check every 60 seconds
done
