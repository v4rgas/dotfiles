#!/usr/bin/env python3
"""Generate a reproducible dot-matrix wallpaper using only the Python stdlib.

Run this script, then rasterize with:
magick -background none bipboplabs.svg bipboplabs.png
"""
from pathlib import Path

# Each character is an explicit 5x7 bitmap; no font or randomness involved.
GLYPHS = {
    'b': ['10000','10000','10110','11001','10001','10001','11110'],
    'i': ['00100','00000','01100','00100','00100','00100','01110'],
    'p': ['00000','00000','11110','10001','11110','10000','10000'],
    'o': ['00000','00000','01110','10001','10001','10001','01110'],
    'l': ['01100','00100','00100','00100','00100','00100','01110'],
    'a': ['00000','00000','01110','00001','01111','10001','01111'],
    's': ['00000','00000','01111','10000','01110','00001','11110'],
}
TEXT = 'bipboplabs'
STEP = 14
ADVANCE = 6 * STEP
WORD_WIDTH = len(TEXT) * ADVANCE
PERIOD = WORD_WIDTH + 1 * STEP
parts = ['''<svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
<title>bipboplabs — deterministic Rosé Pine dot matrix</title>
<defs><linearGradient id="ink" x1="0" x2="1"><stop stop-color="#ea9a97"/><stop offset=".5" stop-color="#c4a7e7"/><stop offset="1" stop-color="#9ccfd8"/></linearGradient></defs>
<rect width="2560" height="1440" fill="#191724"/>
<g transform="rotate(-3 1280 720)">''']
for row in range(-3, 12):
    y = 340 + row * 132
    for col in range(-2, 4):
        x = (2560 - (2 * WORD_WIDTH + 1 * STEP)) / 2 + col * PERIOD
        opacity = 1 if 0 <= row < 6 and col in (0, 1) else .18
        parts.append(f'<g fill="url(#ink)" opacity="{opacity}">')
        for n, letter in enumerate(TEXT):
            t = n / (len(TEXT) - 1)
            stops = ((234,154,151), (196,167,231), (156,207,216))
            a, b = stops[:2] if t < .5 else stops[1:]
            u = t * 2 if t < .5 else (t - .5) * 2
            color = '#' + ''.join(f'{round(v+(w-v)*u):02x}' for v,w in zip(a,b))
            for gy, bits in enumerate(GLYPHS[letter]):
                for gx, bit in enumerate(bits):
                    if bit == '1':
                        parts.append(f'<circle cx="{x+n*ADVANCE+gx*STEP}" cy="{y+gy*STEP}" r="6.2" fill="{color}"/>')
        parts.append('</g>')
parts.append('</g></svg>')
Path(__file__).with_name('bipboplabs.svg').write_text('\n'.join(parts) + '\n')
