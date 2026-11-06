#!/usr/bin/env bash
# Put files on the X11 clipboard so other apps can paste them.
# One image: the image itself (pastes straight into Discord, browsers, editors).
# Anything else: a text/uri-list of file:// links, like PCManFM's copy.
set -euo pipefail
(( $# )) || exit 0

if (( $# == 1 )); then
  mime=$(file -b --mime-type -- "$1")
  case "$mime" in
    image/png|image/jpeg|image/gif|image/webp)
      file=$1; [[ $file == -* ]] && file=./$file   # xclip has no "--"
      exec xclip -selection clipboard -t "$mime" -i "$file"
      ;;
  esac
fi

python3 -I -c '
import os, sys, urllib.parse
for p in sys.argv[1:]:
    sys.stdout.write("file://" + urllib.parse.quote(os.path.abspath(p)) + "\r\n")
' "$@" | xclip -selection clipboard -t text/uri-list
