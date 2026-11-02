#!/usr/bin/env bash
# Pre-publish check: lists unresolved placeholders and OWNER CONFIRM notes, and verifies local links.
cd "$(dirname "$0")" || exit 1
echo "== Placeholders to replace before publishing =="
grep -rnE --include=*.html --include=*.css --include=*.txt --include=*.xml "REPLACE|YOUR_|example\.com|TODO|OWNER CONFIRM|lorem" . || echo "none"
echo
echo "== Owner-confirmation notes (HTML comments) =="
grep -rn --include=*.html "OWNER CONFIRM" . || echo "none"
echo
echo "== Local link check =="
python3 - <<'EOF'
import re, os, sys
bad = 0
for root, _, files in os.walk("."):
    for f in files:
        if not f.endswith(".html"): continue
        p = os.path.join(root, f)
        for m in re.finditer(r'(?:href|src)="([^"#]+)(?:#[^"]*)?"', open(p, encoding="utf-8").read()):
            u = m.group(1)
            if re.match(r"(https?:|mailto:)", u): continue
            t = os.path.normpath(os.path.join(root, u))
            if os.path.isdir(t): t = os.path.join(t, "index.html")
            if not os.path.exists(t):
                print("BROKEN:", p, "->", u); bad += 1
print("all local links OK" if not bad else f"{bad} broken")
EOF
