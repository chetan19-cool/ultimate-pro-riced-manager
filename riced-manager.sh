#!/bin/bash
source ./utils/colors.sh
source ./utils/ask_yes_no.sh
source ./utils/detect_distro.sh
source ./utils/detect_hardware.sh

echo -e "${BLUE}🚀 Ultimate Pro Riced Manager${RESET}"
echo "1) Install / Configure Apps"
echo "2) Restore Backup"
echo "3) Update Pywal & Themes"
echo "4) Backup Current Configs"
echo "5) Exit"

read -p "Choose (1-5): " ACTION

case $ACTION in
1)
    source ./installer/interactive_installer.sh
    ;;
2)
    source ./uninstaller/restore_backups.sh
    ;;
3)
    source ./installer/apply_pywal.sh
    ;;
4)
    mkdir -p ~/.riced-backups/$(date +%Y%m%d-%H%M)
    cp -r ~/.config ~/.zshrc ~/.local ~/.icons ~/.riced-backups/$(date +%Y%m%d-%H%M)/
    log "Backup completed"
    ;;
5)
    log "Exiting..."
    exit 0
    ;;
*)
    warn "Invalid choice."
    ;;
esac
