#!/bin/bash

percent=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

filled=$((percent / 10))
bar=""
for ((i = 0; i < 10; i++)); do
  if [ "$i" -lt "$filled" ]; then
    bar+="█"
  else
    bar+="░"
  fi
done

if [ "$percent" -lt 10 ]; then
  css_class="low"
fi

case "$status" in
"Charging") icon="󰂄" ;;
"Discharging") icon="󰁿" ;;
"Full") icon="󰁹" ;;
*) icon="" ;;
esac

# echo "$icon  [$bar] $percent"
echo "{\"text\": \"$icon  [$bar] $percent\", \"class\": \"$css_class\"}"
