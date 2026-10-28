#!/usr/bin/env bash
# Official Rosé Pine cursor assets, installed per user without sudo.
set -euo pipefail
version=v1.1.0
theme=BreezeX-RosePine-Linux
checksum=b330d59ce8e0e460209f638a97ce772b78d9e6b56ccf63c8a50e9d941289a1af
icons_dir="${XDG_DATA_HOME:-$HOME/.local/share}/icons"
archive_dir=$(mktemp -d)
trap 'rm -rf -- "$archive_dir"' EXIT
curl -fL --silent --show-error "https://github.com/rose-pine/cursors/releases/download/$version/$theme.tar.xz" -o "$archive_dir/cursors.tar.xz"
printf '%s  %s\n' "$checksum" "$archive_dir/cursors.tar.xz" | sha256sum -c -
tar --extract --xz --file "$archive_dir/cursors.tar.xz" --directory "$archive_dir" --no-same-owner --no-same-permissions
[[ -f "$archive_dir/$theme/index.theme" && -f "$archive_dir/$theme/cursors/left_ptr" ]]
mkdir -p "$icons_dir" "$HOME/.icons"
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/cursor-setup/$(date +%Y%m%d-%H%M%S)-$$"
if [[ -e "$icons_dir/$theme" || -L "$icons_dir/$theme" ]]; then
    mkdir -p "$backup_dir"
    mv -- "$icons_dir/$theme" "$backup_dir/theme"
fi
mv -- "$archive_dir/$theme" "$icons_dir/$theme"
# Older Xcursor clients search ~/.icons rather than the XDG data directory.
if [[ $(readlink -f -- "$HOME/.icons/$theme" 2>/dev/null || true) != "$icons_dir/$theme" ]]; then
    if [[ -e "$HOME/.icons/$theme" || -L "$HOME/.icons/$theme" ]]; then
        mkdir -p "$backup_dir"
        mv -- "$HOME/.icons/$theme" "$backup_dir/legacy-theme"
    fi
    ln -s -- "$icons_dir/$theme" "$HOME/.icons/$theme"
fi
printf 'Installed Rosé Pine cursors %s in %s\n' "$version" "$icons_dir/$theme"
