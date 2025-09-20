#!/bin/bash
set -e

# 1) Tambahkan Font Awesome (kalau belum ada)
if ! grep -q "font-awesome" index.html; then
  sed -i '/<\/head>/i \
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">' index.html
fi

# 2) Ganti tombol sosmed jadi icon
sed -i 's|X (Twitter)|<i class="fa-brands fa-x-twitter"></i>|' index.html
sed -i 's|GitHub|<i class="fa-brands fa-github"></i>|' index.html
sed -i 's|LinkedIn|<i class="fa-brands fa-linkedin"></i>|' index.html
sed -i 's|Discord|<i class="fa-brands fa-discord"></i>|' index.html

echo "✅ Icon sosial sudah diganti jadi logo Font Awesome!"
