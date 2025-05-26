#!/bin/bash

mkdir -p converted

declare -A beta_tracks=(
  ["Alpha"]="menu1.ogg"
  ["Blind Spots"]="nether1.ogg"
  ["Taswell"]="creative3.ogg"
  ["Biome Fest"]="creative2.ogg"
  ["Mutation"]="calm2.ogg"
  ["Floating Trees"]="calm3.ogg"
  ["The End"]="end.ogg"
  ["Kyoto"]="underwater1.ogg"
)

for track in "${!beta_tracks[@]}"; do
  input="${track}.mp3"
  output="converted/${beta_tracks[$track]}"
  if [[ -f "$input" ]]; then
    echo "Converting $input -> $output"
    ffmpeg -y -i "$input" -c:a libvorbis -qscale:a 5 "$output"
  else
    echo "Missing: $input"
  fi
done
