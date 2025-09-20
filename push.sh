#!/bin/bash
set -e

# Tambahkan semua perubahan
git add index.html styles.css

# Commit dengan pesan default
git commit -m "fix: update UI (icons + rainbow + links)"

# Push ke branch main
git push origin main

echo "✅ Perubahan sudah di-push ke GitHub!"
