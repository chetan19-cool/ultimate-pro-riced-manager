#!/bin/bash
ask_yes_no() {
    local prompt="$1"
    local default="${2:-N}"
    local answer

    read -p "$prompt [y/N]: " answer
    answer=${answer:-$default}
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}
