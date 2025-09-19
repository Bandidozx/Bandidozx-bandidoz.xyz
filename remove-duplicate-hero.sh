#!/usr/bin/env bash
set -euo pipefail

# Backup dulu
cp index.html index.html.bak

# Hapus <section> yang KEDUA yang mengandung <h1>Bandidoz Playground</h1>
# (case-insensitive, tahan atribut & whitespace, lintas baris)
perl -0777 -pe '
  our $c=0;
  s{
    (<section\b[^>]*>          # buka <section ...>
      .*?                      # isi bebas
      <h1>\s*Bandidoz\s+Playground\s*</h1>  # judul di dalamnya
      .*?                      # sisa isi
    </section>)                # tutup section
  }{
    ++$c==2 ? "" : $1          # keep yang pertama, hapus yang kedua
  }gexis
' index.html > index.html.tmp

# Cek apakah ada perubahan (kalau tidak, jangan timpa)
if cmp -s index.html index.html.tmp; then
  echo "Tidak ada duplikat hero yang terdeteksi. File tidak diubah."
  rm -f index.html.tmp
  exit 0
fi

mv index.html.tmp index.html
echo "Duplikat hero kedua berhasil dihapus."
