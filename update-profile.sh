#!/usr/bin/env bash
set -euo pipefail
NEW="$1"

if [[ ! -f "$NEW" ]]; then
  echo "File tidak ditemukan: $NEW"
  exit 1
fi

rm -f assets/profile.png
cp "$NEW" assets/profile.png

git add assets/profile.png
git commit -m "chore: update profile.png"
git push origin main
