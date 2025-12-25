#!/bin/bash
source ../utils/colors.sh

log "Configuring Kitty terminal..."

mkdir -p ~/.config/kitty
# Backup existing kitty config
if [ -f ~/.config/kitty/kitty.conf ]; then
    cp ~/.config/kitty/kitty.conf ~/.riced-backups/kitty.conf.$(date +%Y%m%d-%H%M)
    log "Backed up existing kitty.conf"
fi

cat > ~/.config/kitty/kitty.conf <<EOF
# Kitty config
font_family FiraCode
font_size 12
background_opacity 0.9
include ~/.cache/wal/colors-kitty.conf
EOF

log "Kitty configuration applied."
