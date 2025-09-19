#!/bin/bash
set -e

mkdir -p data assets/icons

########################
# 1) Airdrop PAGE
########################
cat > airdrop.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Airdrop • Bandidoz</title>
<link rel="icon" type="image/png" href="assets/favicon.png">
<link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="wrap">
  <header class="sub-hero">
    <h1>#WAGMI</h1>
    <p class="muted">Free Airdrop • Paid Airdrop • Testnet • Depin • Social</p>
    <nav class="pill-nav">
      <a href="airdrop.html" class="active">Free Airdrop</a>
      <a href="airdrop.html?tab=paid">Paid Airdrop</a>
      <a href="airdrop.html?tab=ended">Ended</a>
      <a href="index.html">← Back</a>
    </nav>
    <div class="toolbar">
      <input id="q" type="search" placeholder="Search airdrop">
      <select id="filter">
        <option value="ALL">All</option>
        <option value="SOCIAL">SOCIAL</option>
        <option value="TESTNET">TESTNET</option>
        <option value="DEPIN">DEPIN</option>
      </select>
    </div>
  </header>

  <section class="list-card">
    <div class="list-head">
      <div>AIRDROP</div>
      <div>TASK</div>
      <div class="right">LINK</div>
    </div>
    <div id="rows"></div>
    <div class="pager">
      <button id="prev">‹</button>
      <span id="page">1</span>
      <button id="next">›</button>
    </div>
  </section>
</div>
<script src="scripts/airdrop.js"></script>
</body>
</html>
HTML

mkdir -p scripts
cat > scripts/airdrop.js <<'JS'
const pageSize = 10;
let data = [], page = 1;

const dom = (sel) => document.querySelector(sel);
const params = new URLSearchParams(location.search);
const tab = params.get('tab') || 'free';

async function load() {
  const res = await fetch('data/airdrop.json');
  const all = await res.json();
  // simple tab mapping
  data = all.filter(x => (tab==='paid'?x.paid:(tab==='ended'?x.ended:!x.paid && !x.ended)));
  bind();
}

function bind() {
  dom('#q').addEventListener('input', render);
  dom('#filter').addEventListener('change', render);
  dom('#prev').addEventListener('click', () => { if(page>1){page--; render();} });
  dom('#next').addEventListener('click', () => { if(page<Math.ceil(filtered().length/pageSize)){page++; render();} });
  render();
}

function tagBadge(t){
  const color = t==='TESTNET'?'red':t==='SOCIAL'?'purple':t==='DEPIN'?'green':'gray';
  return `<span class="tag ${color}">${t}</span>`;
}

function filtered() {
  const q = dom('#q').value.trim().toLowerCase();
  const f = dom('#filter').value;
  return data.filter(x =>
    (f==='ALL' || x.tag===f) &&
    (x.name.toLowerCase().includes(q))
  );
}

function render() {
  const arr = filtered();
  const total = Math.ceil(arr.length / pageSize);
  if (page>total) page = total || 1;
  const start = (page-1)*pageSize;
  const pageData = arr.slice(start, start+pageSize);

  dom('#rows').innerHTML = pageData.map(x => `
    <div class="list-row">
      <div class="name">${x.name}</div>
      <div>${tagBadge(x.tag)}</div>
      <div class="right"><a class="btn small" href="${x.url}" target="_blank">Visit</a></div>
    </div>
  `).join('');

  dom('#page').textContent = page.toString();
}

load();
JS

cat > data/airdrop.json <<'JSON'
[
  {"name":"Wallchain","tag":"SOCIAL","url":"https://example.com/wallchain","paid":false,"ended":false},
  {"name":"Nebula","tag":"DEPIN","url":"https://example.com/nebula","paid":false,"ended":false},
  {"name":"Pharos","tag":"TESTNET","url":"https://example.com/pharos","paid":false,"ended":false},
  {"name":"Decent","tag":"SOCIAL","url":"https://example.com/decent","paid":false,"ended":false},
  {"name":"ByteNova","tag":"SOCIAL","url":"https://example.com/byte","paid":false,"ended":false},
  {"name":"Linera","tag":"TESTNET","url":"https://example.com/linera","paid":false,"ended":false},
  {"name":"Rise","tag":"TESTNET","url":"https://example.com/rise","paid":false,"ended":false},
  {"name":"Cryplex","tag":"DEPIN","url":"https://example.com/cryplex","paid":false,"ended":false},
  {"name":"Recall","tag":"TESTNET","url":"https://example.com/recall","paid":false,"ended":false},
  {"name":"Dango","tag":"TESTNET","url":"https://example.com/dango","paid":false,"ended":false}
]
JSON

########################
# 2) COMMUNITY PAGE
########################
cat > community.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Crypto Community • Bandidoz</title>
<link rel="icon" type="image/png" href="assets/favicon.png">
<link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="wrap">
  <header class="sub-hero">
    <h1>115 Crypto Community</h1>
    <p class="muted">Made with ♥ by bandidoz</p>
    <div class="toolbar">
      <input id="q" type="search" placeholder="Search by name">
      <div class="chips" id="chips">
        <button data-cat="ALL" class="chip active">All Types</button>
        <button data-cat="Airdrop" class="chip">Airdrop</button>
        <button data-cat="Trading" class="chip">Trading</button>
        <button data-cat="NFT" class="chip">NFT</button>
        <button data-cat="Developer" class="chip">Developer</button>
        <button data-cat="Social" class="chip">Social</button>
        <button data-cat="Web3 Jobs" class="chip">Web3 Jobs</button>
        <button data-cat="Meme Coin" class="chip">Meme Coin</button>
      </div>
    </div>
  </header>

  <section id="cmty-list"></section>

  <div class="pager">
    <button id="prev">‹</button>
    <span id="page">1</span>
    <button id="next">›</button>
  </div>

  <p class="muted" style="text-align:center">Made with ♥ by bandidoz</p>
</div>
<script src="scripts/community.js"></script>
</body>
</html>
HTML

cat > scripts/community.js <<'JS'
const pageSize = 12;
let data = [], page = 1, cat = 'ALL';

const $ = s => document.querySelector(s);

async function load() {
  const r = await fetch('data/community.json');
  data = await r.json();
  bind();
}

function bind() {
  $('#q').addEventListener('input', render);
  document.querySelectorAll('.chip').forEach(b => {
    b.addEventListener('click', () => {
      document.querySelectorAll('.chip').forEach(x => x.classList.remove('active'));
      b.classList.add('active');
      cat = b.dataset.cat;
      page = 1;
      render();
    });
  });
  $('#prev').addEventListener('click', () => { if(page>1){page--; render();} });
  $('#next').addEventListener('click', () => { if(page<Math.ceil(filtered().length/pageSize)){page++; render();} });
  render();
}

function filtered() {
  const q = $('#q').value.trim().toLowerCase();
  return data.filter(x =>
    (cat==='ALL' || x.type===cat) &&
    (x.name.toLowerCase().includes(q))
  );
}

function card(x){
  return `
  <div class="cmty">
    <img src="${x.logo}" alt="${x.name}">
    <div class="meta">
      <div class="title">${x.name}</div>
      <div class="muted">${x.platform}</div>
      <div class="tags"><span class="tag">${x.type}</span></div>
    </div>
    <a class="btn small" href="${x.url}" target="_blank">JOIN</a>
  </div>`;
}

function render(){
  const arr = filtered();
  const total = Math.ceil(arr.length/pageSize);
  if (page>total) page = total || 1;
  const start = (page-1)*pageSize;
  const slice = arr.slice(start, start+pageSize);
  $('#cmty-list').innerHTML = `<div class="cmty-grid">${slice.map(card).join('')}</div>`;
  $('#page').textContent = page;
}

load();
JS

cat > data/community.json <<'JSON'
[
  {"name":"KKPC","platform":"Facebook","type":"Social","url":"https://example.com/kkpc","logo":"https://dummyimage.com/64x64/222/fff&text=K"},
  {"name":"Exsaverse","platform":"Discord","type":"NFT","url":"https://example.com/exsa","logo":"https://dummyimage.com/64x64/222/fff&text=E"},
  {"name":"Bang Pateng","platform":"Telegram","type":"Airdrop","url":"https://example.com/bp","logo":"https://dummyimage.com/64x64/222/fff&text=B"},
  {"name":"Cryptosiast","platform":"Telegram","type":"Airdrop","url":"https://example.com/cry","logo":"https://dummyimage.com/64x64/222/fff&text=C"},
  {"name":"USDTseeker","platform":"Discord","type":"Trading","url":"https://example.com/usdt","logo":"https://dummyimage.com/64x64/222/fff&text=U"},
  {"name":"SolJobs","platform":"Discord","type":"Web3 Jobs","url":"https://example.com/soljobs","logo":"https://dummyimage.com/64x64/222/fff&text=J"},
  {"name":"MemeWaves","platform":"Telegram","type":"Meme Coin","url":"https://example.com/meme","logo":"https://dummyimage.com/64x64/222/fff&text=M"},
  {"name":"Devs Indo","platform":"Discord","type":"Developer","url":"https://example.com/devs","logo":"https://dummyimage.com/64x64/222/fff&text=D"},
  {"name":"NFT Alpha ID","platform":"Discord","type":"NFT","url":"https://example.com/nftalpha","logo":"https://dummyimage.com/64x64/222/fff&text=N"},
  {"name":"Arb Traders","platform":"Telegram","type":"Trading","url":"https://example.com/arb","logo":"https://dummyimage.com/64x64/222/fff&text=A"},
  {"name":"Quest Hunter","platform":"Discord","type":"Airdrop","url":"https://example.com/qh","logo":"https://dummyimage.com/64x64/222/fff&text=Q"},
  {"name":"Degen Ville","platform":"Discord","type":"Meme Coin","url":"https://example.com/degen","logo":"https://dummyimage.com/64x64/222/fff&text=V"}
]
JSON

########################
# 3) STYLES (tambahan kecil)
########################
cat >> styles.css <<'CSS'

/* --- Sub pages shared UI --- */
.sub-hero{background:#0f1728;border:1px solid #1b2a44;border-radius:16px;padding:16px;margin:10px 0 18px}
.pill-nav{display:flex;gap:8px;flex-wrap:wrap;margin:6px 0 12px}
.pill-nav a{padding:6px 10px;border:1px solid #273651;border-radius:999px;color:#cfe6ff;text-decoration:none;background:#0b162a}
.pill-nav a.active{background:#132946;border-color:#375788}
.toolbar{display:flex;gap:10px;align-items:center}
.toolbar input{flex:1;min-width:160px;padding:10px 12px;border-radius:10px;border:1px solid #273651;background:#0b162a;color:#d9e7ff}
.toolbar select{padding:10px 12px;border-radius:10px;border:1px solid #273651;background:#0b162a;color:#d9e7ff}

/* list card (airdrop) */
.list-card{background:#0f1728;border:1px solid #1b2a44;border-radius:16px;overflow:hidden}
.list-head,.list-row{display:grid;grid-template-columns:1fr 140px 120px;gap:10px;padding:12px 14px}
.list-head{background:#0c1424;color:#8fb0d8;font-weight:700}
.list-row{border-top:1px solid #13233b;align-items:center}
.list-row .name{font-weight:600}
.right{text-align:right}
.tag{display:inline-block;padding:2px 8px;border-radius:10px;background:#21324d;color:#cfe6ff;font-size:12px}
.tag.red{background:#3a1620;color:#ff9fb3}
.tag.purple{background:#2d1d3e;color:#d9b3ff}
.tag.green{background:#183226;color:#92f3c7}

/* community grid */
.cmty-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:12px;margin-top:10px}
.cmty{display:grid;grid-template-columns:56px 1fr auto;gap:10px;align-items:center;background:#0f1728;border:1px solid #1b2a44;border-radius:12px;padding:10px}
.cmty img{width:56px;height:56px;border-radius:10px;background:#0b1220;object-fit:cover}
.cmty .title{font-weight:700}
.chips{display:flex;flex-wrap:wrap;gap:8px;margin-top:8px}
.chip{padding:6px 10px;border-radius:999px;border:1px solid #273651;background:#0b162a;color:#cfe6ff}
.chip.active{background:#132946;border-color:#375788}
.pager{display:flex;justify-content:center;gap:10px;margin:14px 0}
.pager button{padding:6px 12px;border:1px solid #273651;border-radius:8px;background:#0b162a;color:#cfe6ff}
.btn.small{padding:6px 10px;border-radius:10px}
CSS

########################
# 4) Commit & push
########################
git add airdrop.html community.html scripts/airdrop.js scripts/community.js data/*.json styles.css
git commit -m "feat: add Airdrop & Community pages with search/filter/pagination"
git push origin main

echo "✅ Done. Pages: airdrop.html & community.html"
