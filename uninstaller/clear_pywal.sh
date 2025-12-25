#!/bin/bash
source ../utils/colors.sh
source ../utils/ask_yes_no.sh

PYWAL_CACHE=~/.cache/wal

if [ ! -d "$PYWAL_CACHE" ]; then
    warn "No Pywal cache found."
    exit 0
fi

if ask_yes_no "Do you want to clear Pywal cache?" "N"; then
    rm -rf "$PYWAL_CACHE"
    log "Pywal cache cleared."
else
    log "Pywal cache clearing canceled."
fi
