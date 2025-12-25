#!/bin/bash
source ../utils/colors.sh

log "Configuring Waybar..."
mkdir -p ~/.config/waybar/scripts

# Backup existing config
if [ -f ~/.config/waybar/config ]; then
    cp ~/.config/waybar/config ~/.riced-backups/waybar_config.$(date +%Y%m%d-%H%M)
    log "Backed up existing Waybar config"
fi

cat > ~/.config/waybar/config <<EOF
{
  "layer": "top",
  "position": "top",
  "modules-left": ["workspaces"],
  "modules-center": ["clock"],
  "modules-right": ["network","bluetooth","battery","cpu","ram","clipboard"]
}
{
    "position": "top",
    "modules-left": ["custom/power", "clock"],
    "modules-center": ["hyprland/workspaces"],
    "modules-right": ["tray", "custom/notification", "pulseaudio","network","bluetooth","battery","clipboard"],

    "position": "top",
    "height": 20,

    "custom/power": {
        "format": " ",
        "tooltip": false,
        # "on-click": "wlogout",
    },

    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "warp-on-scroll": false,
        "format": "{name}",
        "cursor": true,
    },

    "tray": {
        "icon-size": 20,
        "spacing": 10,
        "cursor": true,
	      "on-right-click": "nm-connection-editor"
    },

    "bluetooth": {
        "format": " 󰂯 ",
        "format-disabled": " 󰂲 ",
        "format-connected": " 󰂱 ",
        "format-connected": " {device_alias}",
        "on-click": "blueman-manager",
        "on-click-right": "kitty -e blueman-manager"
    },

    "network": {
        "format-wifi": "  {essid}",
        "format-ethernet": "  Ethernet",
        "format-linked": "  Linked (No IP)",
        "format-disconnected": "  Disconnected",
        "tooltip": false,
	      "on-click": "nm-connection-editor",
        "on-click-right": "kitty -e nmtui"
    },

    "battery": {
        "states": {
            "good": 85,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-full": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
	      "format-plugged": "󱘖 {capacity}%",
        "format-alt": "{icon} {capacity}%",
        "format-icons": [" ", " ", " ", " ", " "],
        "tooltip-format": "{time}",
        "cursor": false,
    },

   "custom/notification": {
        "tooltip": false,
        "format": "{icon}<span><sup>{0}</sup></span>",
        "format-icons": {
            "notification": "󱅫",
            "none": "󰂚",
            "dnd-notification": "󰂛",
            "dnd-none": "󰂛",
            "inhibited-notification": "󱅫",
            "inhibited-none": "󰂚",
            "dnd-inhibited-notification": "󰂛",
            "dnd-inhibited-none": "󰂛"
        },
        "return-type": "json",
        "exec-if": "which swaync-client",
        "exec": "swaync-client -swb",
        "on-click": "bash ~/.config/hypr/scripts/utilBar.sh",
        "on-click-right": "swaync-client -d -sw",
        "escape": true
    },


    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "  {volume}%",
        "format-bluetooth": " {volume}%",
        "format-bluetooth-muted": "  {volume}%",
        "format-icons": {
            "headphone": " ",
            "headset": " ",
            "default": [" "],
        },
        "on-click": "pavucontrol",
    },

    "clock": {
        "format": "{:%a %d %b   %H:%M %p}",
        "tooltip": false,
        "calendar": {
            "mode": "month",
            "format": {
                "months": "<span color='#F5C2E7'><b>{}</b></span>",
                "weekdays": "<span color='#89B4FA'><b>{}</b></span>",
                "days": "<span color='#CDD6F4'><b>{}</b></span>",
                "today": "<span color='#F9E2AF'><b>{}</b></span>",
            }
        },
        "on-click": "if hyprctl clients | grep -q 'class: floating_cal'; then pkill -f 'kitty --class floating_cal'; else kitty --class floating_cal -e bash -c 'cal -y; read'; fi",
    },

     "hyprland/window": {
    "format": " {} ",
    "max-length": 60,
  }
}
EOF

cat > ~/.config/waybar/theme.css <<EOF
@define-color foreground #bbb2a9;
@define-color background #070705;
@define-color cursor #bbb2a9;

@define-color color0 #070705;
@define-color color1 #484939;
@define-color color2 #6A4E38;
@define-color color3 #3F4041;
@define-color color4 #555546;
@define-color color5 #676255;
@define-color color6 #696656;
@define-color color7 #bbb2a9;
@define-color color8 #827c76;
@define-color color9 #484939;
@define-color color10 #6A4E38;
@define-color color11 #3F4041;
@define-color color12 #555546;
@define-color color13 #676255;
@define-color color14 #696656;
@define-color color15 #bbb2a9;

EOF

cat > ~/.config/waybar/style.css <<EOF
* {
  border: none;
  border-radius: 0;
  font-family: "JetBrainsMono Nerd Font", "MesloLGS Nerd Font", "Font Awesome";
  font-weight: bold;
  font-size: 14px;
  min-height: 0;
}

@import "style/theme.css";

window#waybar {
  background: rgba(0, 0, 0, 0.5);
  color: @foreground;
  border-radius: 20px;
}

tooltip {
  background: @background;
  opacity: 0.8;
  border-radius: 15px;
  border-width: 1px;
  border-style: solid;
  border-color: @foreground;
}

tooltip label {
  font-size: 16px;
  color: @foreground;
}

#workspaces button {
  padding: 2px;
  color: @foreground;
  margin-right: 5px;
  background-color: rgba(17, 17, 27, 0);
}

#workspaces button.active {
  color: @background;
  background: @foreground;
  padding: 0 12px;
  margin: 3px 0;
  border-radius: 15px;
}

#workspaces button.focused {
  color: @color8;
  background: transparent;
  border: none;
}

#workspaces button.urgent {
  color: #11111b;
  background: transparent;
  border: none;
}

#workspaces button:hover {
  background: transparent;
  color: @color8;
  border: none;
}

#taskbar button {
  box-shadow: none;
  text-shadow: none;
  padding: 0px;
  border-radius: 9px;
  margin-top: 3px;
  margin-bottom: 3px;
  padding-left: 3px;
  padding-right: 3px;
  animation: gradient_f 20s ease-in infinite;
  transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.682);
}

#taskbar button.active {
  background: #324857;
  margin-left: 3px;
  padding-left: 12px;
  padding-right: 12px;
  margin-right: 3px;
  animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
}

#taskbar button:hover {
  background: #304150;
  padding-left: 3px;
  padding-right: 3px;
  animation: gradient_f 20s ease-in infinite;
  transition: all 0.3s cubic-bezier(0.55, -0.68, 0.48, 1.682);
}

#custom-launch_rofi,
#custom-lock_screen,
#custom-light_dark,
#custom-power_btn,
#custom-weather,
#custom-updater,
#custom-system,
#window,
#cpu,
#disk,
#idle_inhibitor,
#custom-updates,
#custom-clipboard,
#memory,
#clock,
#pulseaudio,
#network,
#tray,
#temperature,
#workspaces,
#taskbar,
#custom-notify,
#battery,
#mpris,
#custom-nightlight,
#hyprland-keyboard,
#power-profiles-daemon,
#backlight {
  background: @background;
  opacity: 0.8;
  padding: 0px 10px;
  margin: 3px 0px;
}

#custom-theme,
#custom-wallpaper {
  background: transparent;
  margin-right: 10px;
  font-size: 14px;
}

#custom-theme {
  margin-right: 15px;
}

#custom-system {
  margin: 3px 10px;
  padding: 0 10px;
  padding-right: 15px;
  background: transparent;
}

#memory,
#cpu,
#disk,
#temperature {
  margin-right: 10px;
  background-color: transparent;
}

#idle_inhibitor {
  font-size: 15px;
  padding: 0 15px;
  background: @background;
  border-radius: 15px 0 0 15px;
  margin-right: 0px;
}

#hyprland-language {
  font-size: 15px;
  margin-right: 20px;
}

#mpris {
  background-color: @background;
  border-radius: 15px;
  padding-left: 15px;
  margin-left: 10px;
}

#custom-notify {
  border-radius: 15px;
  padding: 0 15px;
}

#custom-nightlight {
  border-radius: 0;
}

#battery {
  color: #a6e3a1;
  background-color: transparent;
  margin-right: 0;
  font-size: 14px;
}

@keyframes blink {
  to {
    background-color: #ffffff;
    color: #333333;
  }
}

#battery.critical:not(.charging) {
  color: #f53c3c;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#custom-clipboard {
  border-radius: 0 15px 15px 0;
  font-size: 14px;
  padding-right: 15px;
}

#custom-wallpaper-change {
  font-size: 16px;
  padding-right: 20px;
  border-radius: 0 15px 15px 0;
}

#custom-power_btn {
  color: red;
  padding: 0 15px;
  padding-right: 20px;
  margin-right: 10px;
  border-radius: 15px;
  font-size: 15px;
  font-weight: bolder;
}

#taskbar {
  border-radius: 15px;
}

#network,
#network.speed {
  background-color: transparent;
  font-size: 15px;
}

#custom-updater {
  border-radius: 15px;
  padding: 0 15px;
  margin-right: 10px;
}

#backlight {
  background-color: transparent;
  padding: 0 5px;
}

#custom-launch_rofi {
  padding: 0 15px;
  padding-right: 20px;
  font-size: 15px;
  border-radius: 15px;
  color: @foreground;
  margin-left: 10px;
}

#custom-lock_screen {
  border-radius: 15px;
  padding-right: 13px;
}

#temperature {
  border-radius: 0 10px 10px 0;
}

#tray {
  margin-right: 10px;
  background-color: transparent;
}

#custom-light_dark {
  border-radius: 15px 0 0 15px;
  margin-left: 10px;
  padding: 0 15px;
}

#custom-weather {
  border-radius: 15px;
  margin-left: 10px;
  background-color: transparent;
}

#temperature.critical {
  color: #e92d4d;
}

#workspaces {
  padding: 2px 17px;
  border-radius: 15px;
  margin-left: 10px;
  margin-right: 15px;
}

#window {
  border-radius: 15px;
  margin-left: 20px;
  margin-right: 20px;
}

#pulseaudio {
  background-color: @background;
  border-left: 0px;
  border-right: 0px;
  border-radius: 15px 0 0 15px;
}

#clock {
  border-radius: 15px;
  margin-right: 10px;
  margin-left: 10px;
  padding: 0 20px;
  font-size: 12px;
}

#pulseaudio.microphone {
  /* color: #cba6f7; */
  border-left: 0px;
  border-right: 0px;
  border-radius: 0 15px 15px 0;
}

#power-profiles-daemon {
  background-color: @background;
  border-radius: 15px;
  padding-right: 20px;
  padding-left: 15px;
  /* margin-right: 15px; */
}

#power-profiles-daemon.performance {
  color: #fab387;
  font-size: 15px;
  padding-right: 18px;
}

#power-profiles-daemon.balanced {
  color: #a6e3a1;
  font-size: 15px;
  padding-right: 23px;
}

#power-profiles-daemon.power-saver {
  color: #89dceb;
  font-size: 15px;
}

#custom-cava {
  background: #18202a;
  color: #9db8c1;
  opacity: 0.8;
  padding: 0px 10px;
  margin: 3px 0px;
  margin-right: 10px;
  margin-top: 10px;
  border: 0px;
  border-radius: 15px;
}

EOF

# Example CPU script
echo -e "#!/bin/bash\necho CPU: \$(grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage \"%\"}')" > ~/.config/waybar/scripts/cpu
chmod +x ~/.config/waybar/scripts/cpu

log "Waybar configuration applied."
