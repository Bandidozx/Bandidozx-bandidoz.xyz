#!/bin/bash
set -e

# 1) Tambah Font Awesome (biar bisa load icon)
if ! grep -q "font-awesome" index.html; then
  sed -i '/<\/head>/i \
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">' index.html
fi

# 2) Ganti tombol sosial jadi icon (hapus teks, pasang logo FA)
sed -i 's|X (Twitter)|<i class="fa-brands fa-x-twitter"></i>|g' index.html
sed -i 's|GitHub|<i class="fa-brands fa-github"></i>|g' index.html
sed -i 's|LinkedIn|<i class="fa-brands fa-linkedin"></i>|g' index.html
sed -i 's|Discord|<i class="fa-brands fa-discord"></i>|g' index.html

echo "✅ Ikon sosial berhasil diganti jadi Font Awesome!"
