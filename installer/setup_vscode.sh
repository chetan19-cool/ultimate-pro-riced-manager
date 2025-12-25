#!/bin/bash
source ../utils/colors.sh

log "Configuring VSCode..."
mkdir -p ~/.config/Code/User

cat > ~/.config/Code/User/settings.json <<EOF
{
  "workbench.colorTheme": "WalTheme",
  "editor.fontFamily": "Fira Code",
  "editor.fontSize": 12,
  "window.zoomLevel": 0
}
EOF

log "VSCode configuration applied."
