#!/usr/bin/env python3
"""Install into a named Firefox profile; preserve existing customizations."""
import argparse
import configparser
import datetime
from pathlib import Path
import shutil
import re

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--profile', default='dev-edition-default', help='Profile name in profiles.ini (default: dev-edition-default)')
args = parser.parse_args()
root = Path.home() / '.mozilla/firefox'
config = configparser.ConfigParser()
config.read(root / 'profiles.ini')
profiles = [config[s] for s in config.sections() if s.startswith('Profile') and config[s].get('Name') == args.profile]
if len(profiles) != 1:
    parser.error('Profile not found or ambiguous. Launch Firefox once, then pass --profile NAME.')
entry = profiles[0]
profile = Path(entry['Path'])
if entry.get('IsRelative') == '1':
    profile = root / profile
if not profile.is_dir():
    parser.error('Profile directory does not exist.')
backup = Path.home() / '.local/state/firefox-theme-backups' / datetime.datetime.now().strftime('%Y%m%d-%H%M%S-%f')
source = Path(__file__).resolve().parent / 'theme'
chrome = profile / 'chrome'
chrome.mkdir(exist_ok=True)

def save(path, content):
    if path.exists() and path.read_text() == content:
        return
    if path.exists():
        target = backup / path.relative_to(profile)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    path.write_text(content)

# Remove only the imports installed by the previous custom CSS theme.
for name in ('userChrome.css', 'userContent.css'):
    target = chrome / name
    if target.exists():
        current = target.read_text()
        directive = '@import url("rose-pine-' + name + '");'
        updated = current.replace(directive + '\n', '').replace(directive, '')
        if updated != current:
            save(target, updated)
# Keep geometry separate from the add-on's palette.
save(chrome / 'desktop-corners.css', (source / 'corners.css').read_text())
target = chrome / 'userChrome.css'
current = target.read_text() if target.exists() else ''
directive = '@import url("desktop-corners.css");'
if directive not in current:
    save(target, directive + '\n' + current)

# Prefer dark content and internal pages independently of the GTK setting.
prefs = profile / 'user.js'
current = prefs.read_text() if prefs.exists() else ''
for key, value in (('layout.css.prefers-color-scheme.content-override', 0),
                   ('ui.systemUsesDarkTheme', 1),
                   ('toolkit.legacyUserProfileCustomizations.stylesheets', True)):
    literal = str(value).lower()
    line = f'user_pref("{key}", {literal});'
    pattern = r'^user_pref\("' + re.escape(key) + r'",.*\);[ \t]*$'
    if re.search(pattern, current, re.MULTILINE):
        current = re.sub(pattern, lambda _: line, current, flags=re.MULTILINE)
    else:
        current = current.rstrip() + '\n' + line + '\n'
save(prefs, current)
print(f'Custom Rosé Pine overrides disabled for {args.profile}.')
print('Restart Firefox if it was running, then install/enable Rosé Pine Dark Theme:')
print('https://addons.mozilla.org/en-US/firefox/addon/rose-pine-dark-theme/')
if backup.exists():
    print(f'Backup: {backup}')
