#!/usr/bin/env bash
# Arch / EndeavourOS: install the desktop theme and link this checkout's configs.
set -euo pipefail
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
if (( EUID == 0 )); then
    echo 'Run this as your normal user. Package installation will request sudo.' >&2
    exit 1
fi
command -v pacman >/dev/null || { echo 'This setup currently supports Arch / EndeavourOS.' >&2; exit 1; }
command -v yay >/dev/null || { echo 'Install yay first; Rosé Pine GTK is an AUR package.' >&2; exit 1; }

# Pacman manages the large theme/icon assets; they do not live in this repo.
# Keep AUR build-file review and sudo prompts enabled.
yay -S --needed rose-pine-gtk-theme-full breeze-icons gtk-engine-murrine ttf-jetbrains-mono picom dunst feh imagemagick python curl xorg-xrdb xorg-xsetroot
[[ -f /usr/share/themes/rose-pine-moon-gtk/gtk-3.0/gtk.css ]] || { echo 'rose-pine-moon-gtk was not installed.' >&2; exit 1; }
[[ -f /usr/share/icons/rose-pine-moon-icons/index.theme ]] || { echo 'rose-pine-moon-icons was not installed.' >&2; exit 1; }

"$repo_dir/setup-cursor.sh"

# Back up conflicts, then link individual files. Safe to run again after a pull.
backup_dir="${XDG_STATE_HOME:-$HOME/.local/state}/desktop-setup/$(date +%Y%m%d-%H%M%S)-$$"
for package in desktop rofi i3 ghostty zathura; do
    while IFS= read -r -d '' source_file; do
        relative=${source_file#"$repo_dir/$package/"}
        case "$relative" in
            .config/*|.gtkrc-2.0|.Xresources|.icons/default/index.theme) ;;
            *) continue ;;
        esac
        # Do not deploy historical backups from the i3 package.
        case "$relative" in *.before-*|*.bak) continue ;; esac
        target="$HOME/$relative"
        if [[ $(readlink -f -- "$target" 2>/dev/null || true) == "$source_file" ]]; then
            continue
        fi
        if [[ -e "$target" || -L "$target" ]]; then
            mkdir -p -- "$backup_dir/$(dirname -- "$relative")"
            mv -- "$target" "$backup_dir/$relative"
        fi
        mkdir -p -- "$(dirname -- "$target")"
        ln -s -- "$source_file" "$target"
    done < <(find "$repo_dir/$package" -type f -print0)
done

# Render the deterministic wallpaper at 2560x1440; feh fits each monitor.
mkdir -p "$HOME/.local/share/wallpapers"
python3 "$repo_dir/wallpapers/generate-bipboplabs.py"
magick -background none "$repo_dir/wallpapers/bipboplabs.svg" "$HOME/.local/share/wallpapers/bipboplabs.png"
if [[ -n ${DISPLAY:-} ]]; then
    feh --no-fehbg --bg-fill "$HOME/.local/share/wallpapers/bipboplabs.png"
fi

# Firefox profiles must exist first; opt in to one by name, not machine-specific path.
if [[ -n ${FIREFOX_PROFILE:-} ]]; then
    python3 "$repo_dir/firefox/install.py" --profile "$FIREFOX_PROFILE"
else
    printf 'Firefox: run python3 firefox/install.py --profile NAME after creating a profile.\n'
fi

if command -v gsettings >/dev/null && [[ -n ${DBUS_SESSION_BUS_ADDRESS:-} ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme rose-pine-moon-gtk
    gsettings set org.gnome.desktop.interface icon-theme rose-pine-moon-icons
    gsettings set org.gnome.desktop.interface color-scheme default
    gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux
    gsettings set org.gnome.desktop.interface cursor-size 24
fi
if [[ -n ${DISPLAY:-} ]]; then
    xrdb -merge "$HOME/.Xresources"
    xsetroot -cursor_name left_ptr
fi
if command -v i3-msg >/dev/null && [[ -n ${DISPLAY:-} ]]; then
    i3 -C -c "$HOME/.config/i3/config"
    i3-msg reload
fi
printf 'Rosé Pine Moon configured.\nRestart open GTK apps to refresh their theme.\n'
[[ ! -d "$backup_dir" ]] || printf 'Previous configs: %s\n' "$backup_dir"
