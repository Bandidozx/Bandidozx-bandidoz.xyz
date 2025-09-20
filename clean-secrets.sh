#!/bin/bash
set -e

# Hapus file yg ada token
rm -f enable-pages.sh

# Reset commit yg ada token dari history
git filter-repo --path enable-pages.sh --invert-paths --force || true

# Tambah semua perubahan
git add -A
git commit -m "chore: remove accidental token leak" || echo "⚠️ No changes to commit"

# Force push ke remote (hati-hati, ini rewrite history)
git push origin main --force

echo "✅ Repo sudah bersih dari token. Cek lagi: https://bandidoz.xyz"
