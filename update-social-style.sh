#!/bin/bash
set -e

# Tambahin CSS style untuk social icons
cat >> styles.css <<'CSS'

/* --- Social Icons Bar --- */
.social-icons {
  margin-top: 20px;
  display: flex;
  gap: 15px;
  justify-content: center;
}

.social-icons a img {
  width: 28px;
  height: 28px;
  transition: transform 0.2s, filter 0.2s;
  filter: grayscale(100%);
}

.social-icons a:hover img {
  transform: scale(1.2);
  filter: none;
}

.social-icons a.linkedin:hover img {
  filter: invert(32%) sepia(94%) saturate(2270%) hue-rotate(192deg) brightness(95%) contrast(101%);
}

.social-icons a.twitter:hover img {
  filter: invert(59%) sepia(95%) saturate(400%) hue-rotate(176deg) brightness(95%) contrast(100%);
}

.social-icons a.github:hover img {
  filter: invert(100%);
}

.social-icons a.discord:hover img {
  filter: invert(40%) sepia(80%) saturate(400%) hue-rotate(220deg) brightness(95%) contrast(100%);
}
CSS

# Update index.html (inject class ke tiap <a>)
sed -i 's|href="https://www.linkedin.com/in/bandidoz-x-904720240/" target="_blank"|href="https://www.linkedin.com/in/bandidoz-x-904720240/" target="_blank" class="linkedin"|' index.html
sed -i 's|href="https://x.com/maxwelxyz" target="_blank"|href="https://x.com/maxwelxyz" target="_blank" class="twitter"|' index.html
sed -i 's|href="https://github.com/Bandidozx" target="_blank"|href="https://github.com/Bandidozx" target="_blank" class="github"|' index.html
sed -i 's|href="https://discord.com/users/maxwellxyz" target="_blank"|href="https://discord.com/users/maxwellxyz" target="_blank" class="discord"|' index.html

# Commit & push
git add index.html styles.css
git commit -m "style: enhance social icons with hover effects & branding"
git push origin main

echo "✅ Done! Social icons styled & pushed to GitHub."
