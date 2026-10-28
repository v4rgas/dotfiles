#!/usr/bin/env python3
"""Apply the pinned Moon theme through Vesktop's live-reloaded QuickCSS."""
from pathlib import Path
import datetime
import json
import os
import shutil

source = Path(__file__).resolve().parent
config = Path(os.environ.get('XDG_CONFIG_HOME', str(Path.home() / '.config')))
settings = config / 'vesktop/settings'
settings.mkdir(parents=True, exist_ok=True)
target = settings / 'quickCss.css'
begin = '/* BEGIN DOTFILES ROSE PINE MOON */'
end = '/* END DOTFILES ROSE PINE MOON */'
current = target.read_text() if target.exists() else ''
if begin in current or end in current:
    if current.count(begin) != 1 or current.count(end) != 1:
        raise SystemExit('Theme markers are malformed; leaving QuickCSS unchanged.')
    start = current.index(begin)
    finish = current.index(end) + len(end)
    if finish <= start:
        raise SystemExit('Theme markers are out of order; leaving QuickCSS unchanged.')
    before, after = current[:start], current[finish:]
else:
    before, after = '', current
css = (source / 'rose-pine-moon.css').read_text()
# Omit the pinned theme's optional entrance animations and collapsed search.
# Normal Discord motion/search stay intact; upstream source remains unmodified.
optional_section = '/* More Animations */'
if css.count(optional_section) != 1:
    raise SystemExit('Upstream optional section changed; review the theme before installing.')
css = css.split(optional_section, 1)[0]
css += '\n' + (source / 'compat.css').read_text()
updated = before + begin + '\n' + css.rstrip() + '\n' + end + after
if updated != current:
    if target.exists():
        backup = Path(os.environ.get('XDG_STATE_HOME', str(Path.home() / '.local/state'))) / 'vesktop-theme-backups' / datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')
        backup.mkdir(parents=True)
        shutil.copy2(target, backup / 'quickCss.css')
        print(f'Previous QuickCSS: {backup}')
    # Write in place so Vencord's file watcher reloads it immediately.
    target.write_text(updated)
print(f'Rosé Pine Moon applied to {target}')
prefs = settings / 'settings.json'
if not prefs.exists() or not json.loads(prefs.read_text()).get('useQuickCss', False):
    print('Enable Settings > Vencord > Enable Custom CSS in Vesktop.')
