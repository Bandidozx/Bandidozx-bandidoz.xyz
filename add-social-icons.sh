cat > add-social-icons.sh <<'EOF'
#!/bin/bash
set -e
mkdir -p assets/icons

# LinkedIn
cat > assets/icons/linkedin.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
  <path d="M4.98 3.5C4.98 4.88 3.87 6 2.5 6S0 4.88 0 3.5 1.12 1 2.5 1s2.48 1.12 2.48 2.5zM.5 8h4V24h-4V8zm7.5 0h3.8v2.2h.05c.53-1 1.84-2.2 3.8-2.2 4.06 0 4.8 2.7 4.8 6.2V24h-4v-7.9c0-1.9-.03-4.3-2.6-4.3-2.6 0-3 2-3 4.1V24h-4V8z"/>
</svg>
SVG

# Twitter (X)
cat > assets/icons/twitter.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
  <path d="M23.954 4.569c-.885.389-1.83.654-2.825.775 1.014-.611 1.794-1.574 2.163-2.723-.949.564-2.005.974-3.127 1.195-.897-.959-2.178-1.559-3.594-1.559-2.719 0-4.924 2.205-4.924 4.924 0 .39.045.765.127 1.124-4.094-.205-7.725-2.165-10.159-5.144-.424.729-.666 1.577-.666 2.475 0 1.708.869 3.215 2.188 4.096-.807-.026-1.566-.248-2.229-.616v.061c0 2.385 1.693 4.374 3.946 4.828-.413.111-.849.171-1.296.171-.317 0-.626-.03-.927-.086.627 1.956 2.444 3.379 4.6 3.419-1.68 1.318-3.809 2.105-6.102 2.105-.397 0-.789-.023-1.176-.069 2.179 1.397 4.768 2.212 7.557 2.212 9.054 0 14.004-7.496 14.004-13.986 0-.213-.005-.425-.014-.636.962-.689 1.797-1.56 2.457-2.548z"/>
</svg>
SVG

# GitHub
cat > assets/icons/github.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
  <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.387.6.113.82-.258.82-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.757-1.333-1.757-1.089-.744.083-.729.083-.729 1.205.084 1.84 1.237 1.84 1.237 1.07 1.834 2.807 1.304 3.492.997.108-.775.418-1.305.762-1.605-2.665-.3-5.466-1.334-5.466-5.931 0-1.31.469-2.381 1.236-3.221-.124-.303-.536-1.523.117-3.176 0 0 1.008-.322 3.301 1.23a11.52 11.52 0 0 1 3.003-.404c1.018.005 2.042.138 3.003.404 2.291-1.552 3.297-1.23 3.297-1.23.655 1.653.243 2.873.12 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.628-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.218.694.825.576C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/>
</svg>
SVG

# Discord
cat > assets/icons/discord.svg <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
  <path d="M20 0H4C1.8 0 0 1.8 0 4v16c0 2.2 1.8 4 4 4h12l-.6-2.2 1.4 1.3 1.3 1.2L24 24V4c0-2.2-1.8-4-4-4zm-6.6 18.2s-.6-.7-1-1.3c2-.6 2.8-1.9 2.8-1.9-.6.4-1.1.7-1.6.9-.7.3-1.4.5-2.1.6-1.3.2-2.6.1-3.8-.1-.9-.2-1.8-.4-2.6-.8-.4-.2-.9-.5-1.3-.8-.1-.1-.2-.1-.3-.2-.1-.1-.2-.2-.2-.2s.8 1.3 2.9 1.9c-.4.6-1 1.3-1 1.3-3.2-.1-4.4-2.2-4.4-2.2 0-4.7 2.1-8.5 2.1-8.5 2.1-1.6 4.1-1.6 4.1-1.6l.1.1c-.1 0-1.3.1-2.5.7-1.2.6-1.8 1.5-1.8 1.5s.2-.1.5-.3c2.2-1 4.6-1 4.6-1s2.4 0 4.6 1c.3.2.5.3.5.3s-.6-1-1.8-1.5-2.5-.7-2.5-.7l.1-.1s2 0 4.1 1.6c0 0 2.1 3.8 2.1 8.5 0 0-1.2 2.1-4.4 2.2z"/>
</svg>
SVG

# Sisipkan ke footer index.html (sekali saja)
if ! grep -q 'linkedin.svg' index.html; then
  sed -i '/<\/footer>/i \
  <div class="social-icons">\
    <a href="https:\/\/www.linkedin.com\/in\/bandidoz-x-904720240\/" target="_blank"><img src="assets/icons/linkedin.svg" alt="LinkedIn" width="20"></a>\
    <a href="https:\/\/x.com\/maxwelxyz" target="_blank"><img src="assets/icons/twitter.svg" alt="Twitter" width="20"></a>\
    <a href="https:\/\/github.com\/Bandidozx" target="_blank"><img src="assets/icons/github.svg" alt="GitHub" width="20"></a>\
    <a href="https:\/\/discord.com\/users\/maxwellxyz" target="_blank"><img src="assets/icons/discord.svg" alt="Discord" width="20"></a>\
  </div>' index.html
fi

echo "✅ Social icons (LinkedIn, Twitter, GitHub, Discord) added!"
EOF

chmod +x add-social-icons.sh
