#!/bin/bash
source ../utils/colors.sh

log "Configuring Zsh..."

# Backup existing .zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.riced-backups/.zshrc.$(date +%Y%m%d-%H%M)
    log "Backed up existing .zshrc"
fi

# Minimal prompt
cat > ~/.zshrc <<EOF
# Minimal Zsh config
export ZSH_THEME="minimal"
alias ll='ls -la'
export PATH=\$HOME/bin:\$PATH
EOF

# Set zsh as default shell
if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s $(which zsh)
    log "Set Zsh as default shell"
fi

log "Zsh configuration applied."
