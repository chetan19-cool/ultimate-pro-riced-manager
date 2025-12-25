#!/bin/bash
source ../utils/colors.sh

WALLPAPERS=($(ls ~/Pictures/Wallpapers/*.jpg 2>/dev/null))
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    warn "No wallpapers found, Pywal skipped."
    exit 0
fi

echo "Available wallpapers:"
for i in "${!WALLPAPERS[@]}"; do
    echo "$i) ${WALLPAPERS[$i]}"
done

read -p "Choose wallpaper index to apply: " INDEX
WALLPAPER="${WALLPAPERS[$INDEX]}"

if [ -f "$WALLPAPER" ]; then
    log "Applying Pywal from $WALLPAPER..."
    wal -i "$WALLPAPER" -q
    # Apply Pywal colors to Kitty
    sed -i "s/^background .*/background $(head -n 1 ~/.cache/wal/colors-kitty.conf)/" ~/.config/kitty/kitty.conf
    # Apply Pywal colors to Waybar
    sed -i "s/#1e1e2e/$(head -n 1 ~/.cache/wal/colors)/" ~/.config/waybar/style.css
    log "Pywal applied to Kitty, Waybar, and VSCode."
else
    warn "Invalid wallpaper selection."
fi
