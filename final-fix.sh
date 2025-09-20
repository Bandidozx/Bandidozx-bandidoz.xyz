#!/bin/bash
set -e

AIRDROP="https://airdrop.nekowawolf.xyz/"
COMMUNITY="https://cmty.nekowawolf.xyz/"

# 0) sinkron ke remote
git fetch origin
git checkout -B main origin/main

# 1) backup
cp -n index.html index.html.bak 2>/dev/null || true
cp -n script.js  script.js.bak  2>/dev/null || true

# 2) bersihkan onclick yg bisa override link
sed -i -E 's/\s+on(click|mouse[a-z]+)="[^"]*"//gi' index.html

# 3) pastikan anchor Airdrop & Community ber-href final (+ target blank)
#    (replace seluruh tag <a ...id="btn-airdrop"...> dan <a ...id="btn-community"...>)
sed -i -E 's|<a([^>]*id="btn-airdrop"[^>]*)>.*?</a>|<a class="btn" id="btn-airdrop" href="'$AIRDROP'" target="_blank" rel="noopener">→ Buka Airdrop Board</a>|gi' index.html
sed -i -E 's|<a([^>]*id="btn-community"[^>]*)>.*?</a>|<a class="btn" id="btn-community" href="'$COMMUNITY'" target="_blank" rel="noopener">→ Buka Community List</a>|gi' index.html

# 4) ganti placeholder di script.js kalau ada
sed -i "s|\$AIRDROP_URL|$AIRDROP|g" script.js || true
sed -i "s|\$COMMUNITY_URL|$COMMUNITY|g" script.js || true

# 5) tambahkan safety patch di akhir script.js (force href saat load)
PATCH='
try {
  document.addEventListener("DOMContentLoaded", function () {
    var a = document.getElementById("btn-airdrop");
    if (a) { a.setAttribute("href", "'$AIRDROP'"); a.setAttribute("target","_blank"); a.setAttribute("rel","noopener"); }
    var c = document.getElementById("btn-community");
    if (c) { c.setAttribute("href", "'$COMMUNITY'"); c.setAttribute("target","_blank"); c.setAttribute("rel","noopener"); }
  });
} catch(e) {}
'
# tambahkan patch hanya kalau belum ada
grep -q "btn-community" script.js || printf "\n%s\n" "$PATCH" >> script.js

# 6) commit & push
git add index.html script.js
git commit -m "fix: force real Airdrop/Community links + remove onclick + runtime safety patch" || echo "⚠️ No changes to commit"
git push origin main

echo "✅ Didorong ke GitHub Pages. Tunggu ±1–2 menit lalu hard refresh (Ctrl+Shift+R) https://bandidoz.xyz"
