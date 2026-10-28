Vesktop — Rosé Pine Moon

Run from the dotfiles checkout:
  python3 vesktop/install.py

Uses Vencord's QuickCSS (Settings > Vencord > Enable Custom CSS). When enabled,
Vesktop reloads changes live. The installer replaces only its marked theme block,
preserves other custom CSS after it, and backs up edits under
~/.local/state/vesktop-theme-backups. Rerun after pulling theme changes.
No accounts, cookies, tokens or plugin settings are stored in this repository.
Native Linux Vesktop is supported; Flatpak uses a different config location.

Source: https://github.com/rose-pine/discord
REVISION pins the source commit; LICENSE contains the upstream MIT license.
rose-pine-moon.css is the upstream theme, including its layout customizations.
compat.css follows it with Moon background tokens for surfaces the upstream
component selectors miss, including Discord's Midnight sidebar backgrounds.
Palette roles are shared across DMs, servers, Friends and settings: base
(#232136) for the canvas/gutters; surface (#2a273f) for persistent panels;
overlay (#393552) for raised cards, menus and fields; highlight (#44415a) for
selections/borders. Common panel gaps are 8px. New Discord/Vencord card, input,
text and icon tokens are mapped too. Personal banners, avatars, custom profile
gradients and semantic status/accent colors remain distinct.
Local adjustments hide the theme label, retain and refine server unread/selected
markers, and match the desktop's 8px panels/menus and 4px controls. Circular
avatars/status indicators retain their shape. The installer omits upstream's
final optional "More Animations" and "Collapsible Search Bar" sections: member
lists/user cards no longer slide in, and normal Discord search remains usable.
The server rail and channel/DM list reserve space above the measured user-panel
height, without Discord's overlapping fade or decorative bottom strip, keeping unread badges
clear of the panel's rounded corners (including expanded voice controls).
The CSS references the upstream logo on GitHub and a Google Fonts stylesheet.
