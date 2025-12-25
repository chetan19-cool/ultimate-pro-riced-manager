#!/bin/bash
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    DISTRO=$(uname -s)
fi
log "Detected distro: $DISTRO"

case "$DISTRO" in
    arch|manjaro|endeavouros)
        PKG_INSTALL="sudo pacman -S --noconfirm"
        PKG_UPDATE="sudo pacman -Syu --noconfirm"
        ;;
    ubuntu|debian)
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update && sudo apt upgrade -y"
        ;;
    fedora)
        PKG_INSTALL="sudo dnf install -y"
        PKG_UPDATE="sudo dnf upgrade -y"
        ;;
    *)
        error "Unsupported distro: $DISTRO"
        exit 1
        ;;
esac
