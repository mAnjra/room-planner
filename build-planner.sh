#!/bin/sh
# Splice three.js into the source to produce the single self-contained app.
set -e
DIR=$(dirname "$0")
SRC="$DIR/room-planner_v4.src.html"
LIB="${THREE_JS:-$DIR/vendor/three.min.js}"
OUT="$DIR/room-planner_v4.html"
python3 - "$SRC" "$LIB" "$OUT" <<'PY'
import sys
src, lib, out = sys.argv[1], sys.argv[2], sys.argv[3]
html = open(src, encoding='utf-8').read()
three = open(lib, encoding='utf-8').read()
marker = '<!--INLINE_THREE-->'
assert marker in html, 'marker missing from source'
html = html.replace(marker, '<script>\n' + three + '\n</script>')
open(out, 'w', encoding='utf-8').write(html)
print('%s  %.1f KB' % (out, len(html.encode()) / 1024))
PY
