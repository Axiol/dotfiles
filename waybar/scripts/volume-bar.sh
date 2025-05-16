#!/bin/bash

# Récupère le volume avec pamixer (ou amixer si tu préfères)
volume=$(pamixer --get-volume)

# Option : afficher icône muet si nécessaire
mute=$(pamixer --get-mute)
if [ "$mute" = "true" ]; then
  icon=""
else
  icon=""
fi

if [[ "$volume" -lt 10 || "$mute" == "true" ]]; then
  css_class="low"
fi

# Barre : 10 segments
bars=""
filled=$((volume / 10))
for ((i = 0; i < 10; i++)); do
  if [ "$i" -lt "$filled" ]; then
    bars+="█"
  else
    bars+="░"
  fi
done

# echo "$icon  [$bars] $volume"
echo "{\"text\": \"$icon  [$bars] $volume\", \"class\": \"$css_class\"}"
