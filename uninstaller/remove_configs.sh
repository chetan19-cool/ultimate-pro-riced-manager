#!/bin/bash
source ../utils/colors.sh
source ../utils/ask_yes_no.sh

CONFIG_DIRS=(~/.config/kitty ~/.config/hyprland ~/.config/waybar ~/.config/Code ~/.config/BraveSoftware ~/.zshrc ~/.icons)

echo "This will remove the following configs:"
for dir in "${CONFIG_DIRS[@]}"; do
    echo "- $dir"
done

if ask_yes_no "Do you want to proceed?" "N"; then
    for dir in "${CONFIG_DIRS[@]}"; do
        if [ -e "$dir" ]; then
            rm -rf "$dir"
            log "Removed $dir"
        fi
    done
    log "All selected configs removed."
else
    log "Removal canceled."
fi
