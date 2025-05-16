#!/bin/bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$((100 * brightness / max_brightness))

# Construire une barre de 10 blocs
filled=$((percent / 10))
bar=""
for ((i = 0; i < 10; i++)); do
  if [ "$i" -lt "$filled" ]; then
    bar+="█"
  else
    bar+="░"
  fi
done

echo "󱩏  [$bar] $percent"
