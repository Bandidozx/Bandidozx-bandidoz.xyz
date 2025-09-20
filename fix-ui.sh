#!/bin/bash
set -e

# === 1. Update index.html untuk link dan ikon sosmed ===
sed -i 's|X (Twitter)|<i class="fa-brands fa-x-twitter"></i>|' index.html
sed -i 's|GitHub|<i class="fa-brands fa-github"></i>|' index.html
sed -i 's|LinkedIn|<i class="fa-brands fa-linkedin"></i>|' index.html
sed -i 's|Discord|<i class="fa-brands fa-discord"></i>|' index.html

# Update href ke link bener
sed -i 's|href="[^"]*fa-x-twitter"|href="https://x.com/maxwelxyz" target="_blank"><i class="fa-brands fa-x-twitter"|' index.html
sed -i 's|href="[^"]*fa-github"|href="https://github.com/Bandidozx" target="_blank"><i class="fa-brands fa-github"|' index.html
sed -i 's|href="[^"]*fa-linkedin"|href="https://linkedin.com/in/bandidoz-x" target="_blank"><i class="fa-brands fa-linkedin"|' index.html
sed -i 's|href="[^"]*fa-discord"|href="https://discord.gg/bandidoz" target="_blank"><i class="fa-brands fa-discord"|' index.html

# === 2. Perbaiki link Airdrop & Community ===
sed -i 's|→ Buka Airdrop Board|→ Buka Airdrop Board|' index.html
sed -i 's|href="[^"]*Buka Airdrop Board|href="https://airdrop.nekowawolf.xyz/" target="_blank">→ Buka Airdrop Board|' index.html

sed -i 's|→ Buka Community List|→ Buka Community List|' index.html
sed -i 's|href="[^"]*Buka Community List|href="https://cmty.nekowawolf.xyz/" target="_blank">→ Buka Community List|' index.html

# === 3. Tambah efek rainbow di judul ===
if ! grep -q "rainbow-text" styles.css; then
cat <<'CSS' >> styles.css

/* Rainbow effect untuk judul */
.rainbow-text {
  background: linear-gradient(90deg, red, orange, yellow, green, cyan, blue, violet);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: rainbow-move 5s linear infinite;
}
@keyframes rainbow-move {
  0% { background-position: 0% 50%; }
  100% { background-position: 100% 50%; }
}
CSS
fi

# Tambah class ke judul di index.html
sed -i 's|<h1>Web3 Playground</h1>|<h1 class="rainbow-text">Web3 Playground</h1>|' index.html

echo "✅ UI sudah diperbaiki: ikon sosmed, rainbow title, dan link beres!"
