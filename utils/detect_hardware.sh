#!/bin/bash
CPU_MODEL=$(lscpu | grep "Model name" | awk -F: '{print $2}' | xargs)
GPU_MODEL=$(lspci | grep -E "VGA|3D" | awk -F: '{print $3}' | xargs)
RAM_SIZE=$(free -h | grep Mem | awk '{print $2}')
MONITORS=$(xrandr --listmonitors | tail -n +2 | awk '{print $4}')

log "CPU: $CPU_MODEL"
log "GPU: $GPU_MODEL"
log "RAM: $RAM_SIZE"
log "Monitors: $MONITORS"
