#!/bin/bash
set -e
mkdir -p assets/icons

# Buat ikon LinkedIn kalau belum ada
cat > assets/icons/linkedin.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
  <path d="M4.98 3.5C4.98 4.88 3.87 6 2.5 6S0 4.88 0 3.5 1.12 1 2.5 1s2.48 1.12 2.48 2.5zM.5 8h4V24h-4V8zm7.5 0h3.8v2.2h.05c.53-1 1.84-2.2 3.8-2.2 4.06 0 4.8 2.7 4.8 6.2V24h-4v-7.9c0-1.9-.03-4.3-2.6-4.3-2.6 0-3 2-3 4.1V24h-4V8z"/>
</svg>
SVG

# Sisipkan link LinkedIn ke footer sebelum </footer> jika belum ada
if ! grep -q 'linkedin.svg' index.html; then
  sed -i '/<\/footer>/i \
  <a href="https:\/\/www.linkedin.com\/in\/bandidoz-x-904720240\/" target="_blank">\
    <img src="assets/icons/linkedin.svg" alt="LinkedIn" width="20" height="20">\
  </a>' index.html
fi

echo "✅ LinkedIn icon added (idempotent)."
