#!/bin/bash
source ../utils/colors.sh

log "Configuring Brave browser..."
mkdir -p ~/.config/BraveSoftware/Brave-Browser/Default

cat > ~/.config/BraveSoftware/Brave-Browser/Default/Preferences <<EOF
{"browser":{"theme":{"dark_mode":true}}}
EOF

log "Brave configuration applied."
