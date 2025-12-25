#!/bin/bash
source ../utils/colors.sh
source ../utils/ask_yes_no.sh
source ../utils/detect_distro.sh
source ../utils/detect_hardware.sh

declare -A apps=(
  [kitty]="Kitty Terminal"
  [zsh]="Zsh Shell"
  [hyprland]="Hyprland Window Manager"
  [waybar]="Waybar Status Bar"
  [brave]="Brave Browser"
  [code]="VSCode IDE"
  [pywal]="Pywal Theme Engine"
)

log "Starting interactive installation..."

for app in "${!apps[@]}"; do
    if ask_yes_no "Do you want to install ${apps[$app]}?" "N"; then
        if command -v $app >/dev/null 2>&1; then
            log "$app is already installed."
            if ask_yes_no "Do you want to apply its configuration anyway?" "N"; then
                if [ -f ./setup_$app.sh ]; then
                    source ./setup_$app.sh
                else
                    warn "No setup script for $app"
                fi
            else
                log "Skipping configuration for $app."
            fi
        else
            log "Installing $app..."
            $PKG_INSTALL $app
            if [ -f ./setup_$app.sh ]; then
                source ./setup_$app.sh
            else
                warn "No setup script for $app"
            fi
        fi
    else
        warn "Skipping $app."
    fi
done
if [ "$DISTRO" = "arch" ]; then
    sudo pacman -Syu --needed --noconfirm \
        hyprland waybar kitty rofi \
        swaybg swaylock wl-clipboard \
        grim slurp git wget curl \
        ttf-jetbrains-mono ttf-font-awesome \
        papirus-icon-theme noto-fonts

elif [ "$DISTRO" = "fedora" ]; then
    sudo dnf install -y \
        hyprland waybar kitty rofi \
        swaybg swaylock wl-clipboard \
        grim slurp git wget curl \
        jetbrains-mono-fonts fontawesome-fonts \
        papirus-icon-theme google-noto-fonts
fi

# Fonts installation
echo "Available fonts:"
FONTS=("Fira Code" "JetBrains Mono" "Source Code Pro" "Hack" "Nerd Fonts")
select FONT_CHOICE in "${FONTS[@]}" "Skip"; do
    case $FONT_CHOICE in
        "Skip")
            log "Skipping font installation."
            break
            ;;
        *)
            log "Installing $FONT_CHOICE..."
            case "$DISTRO" in
                arch|manjaro|endeavouros)
                    $PKG_INSTALL "${FONT_CHOICE// /-}-ttf"
                    ;;
                ubuntu|debian)
                    $PKG_INSTALL "fonts-${FONT_CHOICE,,}"  # lowercase for apt package
                    ;;
                *)
                    warn "Font installation not supported on $DISTRO"
                    ;;
            esac
            log "$FONT_CHOICE installed."
            break
            ;;
    esac
done


# Apply Pywal if wallpapers exist
if [ -d ~/Pictures/Wallpapers ]; then
    if ask_yes_no "Do you want to apply Pywal from wallpapers?" "Y"; then
        source ./apply_pywal.sh
    fi
fi


# Final message
log "Installation complete! Restart your session to apply Hyprland and Waybar settings."
