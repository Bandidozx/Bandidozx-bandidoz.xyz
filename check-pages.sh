#!/bin/bash
set -e

echo "🔍 Cek GitHub Pages setup..."

# 1. Pastikan index.html ada
if [ -f index.html ]; then
  echo "✅ index.html ada di root"
else
  echo "❌ index.html TIDAK ada di root"
fi

# 2. Pastikan CNAME ada & isinya benar
if [ -f CNAME ]; then
  echo -n "📄 Isi CNAME: "
  cat CNAME
  echo
else
  echo "❌ File CNAME tidak ada"
fi

# 3. Cek apakah domain ada di setting GitHub remote
git remote -v

# 4. Cek branch & sinkron
git status
git branch -vv | grep main || true

# 5. Reminder Pages
echo "⚡ Kalau masih 404:"
echo "   1. Masuk ke GitHub → Settings → Pages"
echo "   2. Pastikan Source = 'main' dan folder = '/' (root)"
echo "   3. Simpan → tunggu 1-2 menit → cek https://bandidoz.xyz"
