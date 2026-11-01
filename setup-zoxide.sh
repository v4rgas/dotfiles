#!/usr/bin/env bash
# Enable directory jumping without replacing the user's shell configuration.
set -euo pipefail
zshrc="${ZDOTDIR:-$HOME}/.zshrc"
if [[ -f $zshrc ]] && grep -Fq 'eval "$(zoxide init zsh)"' "$zshrc"; then
    printf 'Zoxide is already configured in %s.\n' "$zshrc"
    exit 0
fi
if [[ -f $zshrc ]]; then
    backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/zoxide-setup/$(date +%Y%m%d-%H%M%S)-$$"
    mkdir -p "$backup_dir"
    cp -p -- "$zshrc" "$backup_dir/zshrc"
fi
mkdir -p -- "$(dirname "$zshrc")"
cat >> "$zshrc" <<'EOF'

# Learn visited directories: z jumps directly; zi opens a fuzzy picker.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi
EOF
printf 'Zoxide configured. Open a new terminal to use z and zi.\n'
