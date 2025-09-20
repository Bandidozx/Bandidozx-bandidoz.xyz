#!/bin/bash
set -e

# Pastikan Font Awesome dimuat di <head>
if ! grep -q "font-awesome" index.html; then
  sed -i '/<\/head>/i \
  <!-- Font Awesome -->\n  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" />\n' index.html
fi

# Ganti tombol sosmed pakai ikon Font Awesome
sed -i 's|X (Twitter)|<i class="fab fa-x-twitter"></i>|g' index.html
sed -i 's|GitHub|<i class="fab fa-github"></i>|g' index.html
sed -i 's|LinkedIn|<i class="fab fa-linkedin"></i>|g' index.html
sed -i 's|Discord|<i class="fab fa-discord"></i>|g' index.html

echo "✅ Ikon sosial sudah diaktifkan (Font Awesome)."
