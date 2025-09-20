#!/bin/bash
set -e

# Tambah file yg berubah
git add index.html script.js

# Commit aman (skip kalau nggak ada perubahan)
git commit -m "fix: hardcode airdrop & community links" || echo "⚠️ No changes to commit"

# Tarik dulu biar branch sinkron
git pull origin main --rebase || true

# Push ke main
git push origin main

echo "✅ Deploy terkirim ke GitHub Pages!"
echo "⏳ Tunggu ±2 menit lalu cek: https://bandidoz.xyz"
