#!/run/current-system/sw/bin/bash

dragon-drop -t -k --print-path | grep -v "^$" | while IFS= read -r path; do
  name="$(basename "$path")"
  base="${name%.*}"
  ext="${name##*.}"
  [ "$base" = "$ext" ] && ext="" || ext=".$ext"
  target="./$base$ext"
  i=1
  while [ -e "$target" ]; do
    target="./${base}_$i$ext"
    i=$((i + 1))
  done
  cp -rv "$path" "$target" && notify-send "Copied: $name → $(basename "$target")"
done
