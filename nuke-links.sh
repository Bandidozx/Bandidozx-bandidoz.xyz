#!/bin/bash
set -e

AIRDROP="https://airdrop.nekowawolf.xyz/"
COMMUNITY="https://cmty.nekowawolf.xyz/"

# 1) Ganti placeholder di SEMUA file (html/js/json/md/txt)
FILES=$(git ls-files | grep -E '\.(html|js|json|md|txt)$' || true)
for f in $FILES; do
  sed -i "s|\$AIRDROP_URL|${AIRDROP}|g" "$f"
  sed -i "s|\$COMMUNITY_URL|${COMMUNITY}|g" "$f"
done

# 2) Paksa tombol di index.html langsung punya href
if [ -f index.html ]; then
  sed -i -E "s|<a([^>]*id=\"btn-airdrop\"[^>]*)>.*?</a>|<a class=\"btn\" id=\"btn-airdrop\" href=\"${AIRDROP}\" target=\"_blank\" rel=\"noopener\">→ Buka Airdrop Board</a>|gi" index.html
  sed -i -E "s|<a([^>]*id=\"btn-community\"[^>]*)>.*?</a>|<a class=\"btn\" id=\"btn-community\" href=\"${COMMUNITY}\" target=\"_blank\" rel=\"noopener\">→ Buka Community List</a>|gi" index.html
  # bersihin onclick yang ganggu
  sed -i -E 's/\s+on(click|mouse[a-z]+)="[^"]*"//gi' index.html
fi

# 3) Tambahkan patch JS supaya kalau masih ada placeholder, tetap dipaksa ke final link
if [ -f script.js ] && ! grep -q "force btn-community href" script.js; then
  cat >> script.js <<EOF

// force btn airdrop/community href (safety)
document.addEventListener("DOMContentLoaded", function () {
  var a = document.getElementById("btn-airdrop");
  if (a) { a.setAttribute("href","${AIRDROP}"); a.setAttribute("target","_blank"); a.setAttribute("rel","noopener"); }
  var c = document.getElementById("btn-community");
  if (c) { c.setAttribute("href","${COMMUNITY}"); c.setAttribute("target","_blank"); c.setAttribute("rel","noopener"); }
});
EOF
fi

# 4) Cek apakah masih ada placeholder
echo "---- Sisa placeholder (kalau ada) ----"
grep -RIn '\$AIRDROP_URL\|\$COMMUNITY_URL' || echo "(bersih ✅)"
echo "--------------------------------------"

# 5) Commit & push
git add -A
git commit -m "fix: nuke placeholders + force final links" || echo "⚠️ No changes to commit"
git push origin main

echo "✅ Didorong ke GitHub. Tunggu ±1–2 menit, lalu hard refresh (Ctrl+Shift+R) https://bandidoz.xyz"
