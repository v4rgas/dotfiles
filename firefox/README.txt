Firefox — Rosé Pine Dark Theme

Selected theme (main Rosé Pine palette), by Bullfinch:
https://addons.mozilla.org/en-US/firefox/addon/rose-pine-dark-theme/

On each computer, install and enable this theme through Firefox's add-on page.
Firefox handles the signed theme and its updates. No profile data is in Git.

If the previous custom CSS theme was installed, run:
  python3 firefox/install.py
For another profile use --profile NAME. Restart Firefox afterward to unload
its custom styles. The script removes only our Rosé Pine import lines and
backs up changes under ~/.local/state/firefox-theme-backups.

The theme/ and upstream/ directories retain the previous inactive CSS and
its source/license for reference. They are no longer deployed by the installer.
The add-on supplies colors; Firefox retains native controls and layout.

The installer also sets dark content appearance and the Firefox-only system
color preference so internal pages stay dark without changing the GTK theme.
Restart Firefox after running it. Websites with a dark mode can honor this
preference; it does not recolor sites that only support a light appearance.

Vendored upstream CSS has trailing whitespace normalized.
