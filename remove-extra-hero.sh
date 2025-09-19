#!/bin/bash
# Hapus hero section kedua dari index.html

# Backup dulu
cp index.html index.html.bak

# Hapus baris antara <!-- HERO-SECOND --> dan <!-- END-HERO-SECOND -->
sed -i '/<!-- HERO-SECOND -->/,/<!-- END-HERO-SECOND -->/d' index.html

git add index.html remove-extra-hero.sh
git commit -m "remove: extra hero section (double banner)"
git push
