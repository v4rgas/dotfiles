#!/usr/bin/env python3
"""Generate a reproducible dot-matrix wallpaper using only the Python stdlib.

Run this script, then rasterize with:
magick -background none bipboplabs.svg bipboplabs.png
"""
from pathlib import Path

# Each character is an explicit 5x7 bitmap; no font or randomness involved.
GLYPHS = {
    ' ': ['00000'] * 7,
    't': ['00100','00100','11111','00100','00100','00101','00010'],
    'u': ['00000','00000','10001','10001','10001','10011','01101'],
    'r': ['00000','00000','10110','11001','10000','10000','10000'],
    'n': ['00000','00000','11110','10001','10001','10001','10001'],
    'g': ['00000','01111','10001','10001','01111','00001','01110'],
    'c': ['00000','00000','01111','10000','10000','10000','01111'],
    'e': ['00000','00000','01110','10001','11111','10000','01110'],
    'd': ['00001','00001','01101','10011','10001','10001','01111'],
    'h': ['10000','10000','10110','11001','10001','10001','10001'],
    'b': ['10000','10000','10110','11001','10001','10001','11110'],
    'i': ['00100','00000','01100','00100','00100','00100','01110'],
    'p': ['00000','00000','11110','10001','11110','10000','10000'],
    'o': ['00000','00000','01110','10001','10001','10001','01110'],
    'l': ['01100','00100','00100','00100','00100','00100','01110'],
    'a': ['00000','00000','01110','00001','01111','10001','01111'],
    's': ['00000','00000','01111','10000','01110','00001','11110'],
}
LINES = ('turning unstructured data', 'into actionable insights')
STEP = 14
ADVANCE = 6 * STEP
SPACE_ADVANCE = 3 * STEP
parts = ['''<svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1440" viewBox="0 0 2560 1440">
<title>Turning unstructured data into actionable insights — Rosé Pine dot matrix</title>
<defs><linearGradient id="ink" x1="0" x2="1"><stop stop-color="#ea9a97"/><stop offset=".5" stop-color="#c4a7e7"/><stop offset="1" stop-color="#9ccfd8"/></linearGradient></defs>
<rect width="2560" height="1440" fill="#191724"/>
<g transform="rotate(-3 1280 720)">''']
for row in range(-3, 12):
    # Keep each two-line phrase together, with extra space between repetitions.
    y = 238 + (row // 2) * 360 + (row % 2) * 160
    text = LINES[row % len(LINES)]
    positions = []
    cursor = 0
    for letter in text:
        positions.append(cursor)
        cursor += SPACE_ADVANCE if letter == " " else ADVANCE
    word_width = cursor - STEP
    for col in range(-1, 2):
        x = (2560 - word_width) / 2 + col * (word_width + 6 * STEP)
        opacity = 1 if 0 <= row < 6 and col == 0 else .18
        parts.append(f'<g fill="url(#ink)" opacity="{opacity}">')
        for n, letter in enumerate(text):
            t = n / (len(text) - 1)
            stops = ((234,154,151), (196,167,231), (156,207,216))
            a, b = stops[:2] if t < .5 else stops[1:]
            u = t * 2 if t < .5 else (t - .5) * 2
            color = '#' + ''.join(f'{round(v+(w-v)*u):02x}' for v,w in zip(a,b))
            for gy, bits in enumerate(GLYPHS[letter]):
                for gx, bit in enumerate(bits):
                    if bit == '1':
                        parts.append(f'<circle cx="{x+positions[n]+gx*STEP}" cy="{y+gy*STEP}" r="6.7" fill="{color}"/>')
        parts.append('</g>')
parts.append('</g></svg>')
Path(__file__).with_name('bipboplabs.svg').write_text('\n'.join(parts) + '\n')
