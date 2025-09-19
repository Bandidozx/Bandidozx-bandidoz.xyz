const $ = s => document.querySelector(s);
$("#y").textContent = new Date().getFullYear();

// simple CoinGecko fetch (no key)
(async ()=>{
  try{
    const r = await fetch("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd",{cache:"no-store"});
    const j = await r.json();
    const fmt = n => "$"+Number(n).toLocaleString();
    $("#btc").textContent = fmt(j.bitcoin.usd);
    $("#eth").textContent = fmt(j.ethereum.usd);
    $("#sol").textContent = fmt(j.solana.usd);
  }catch(e){ console.warn("coingecko err",e); }
})();

// === LIVE TICKER (CoinGecko) ===
const $id = (x)=>document.getElementById(x);

function fmtUSD(n){ return "$"+Number(n).toLocaleString(undefined,{maximumFractionDigits:0}); }
function fmtPct(n){ return (n>0?"+":"")+n.toFixed(2)+"%"; }

async function fetchPrices(){
  const url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd&include_24hr_change=true";
  const r = await fetch(url, {cache:"no-store"});
  if(!r.ok) throw new Error("coingecko "+r.status);
  return r.json();
}

function buildTicker(data){
  // data shape: { bitcoin:{usd, usd_24h_change}, ... }
  const items = [
    {sym:"BTC", d:data.bitcoin},
    {sym:"ETH", d:data.ethereum},
    {sym:"SOL", d:data.solana},
  ].map(({sym,d})=>{
    const ch = d.usd_24h_change || 0;
    const cls = ch>=0 ? "pos" : "neg";
    return `
      <span class="ti">
        <span>${sym}</span>
        <b>${fmtUSD(d.usd)}</b>
        <span class="chg ${cls}">${fmtPct(ch)}</span>
      </span>`;
  }).join("");

  // gandakan konten agar animasi 100%->-50% mulus
  const track = items + items;
  $id("ticker-track").innerHTML = track;
}

async function refreshTicker(){
  try{
    const j = await fetchPrices();
    buildTicker(j);
  }catch(e){
    console.warn("ticker error", e);
  }
}

// load awal & interval
if($id("ticker-track")){
  refreshTicker();
  setInterval(refreshTicker, 60_000); // update tiap 60 detik
}

/* HERO NODE NETWORK */
(function(){
  const cv = document.getElementById('hero-canvas');
  if(!cv) return;

  const ctx = cv.getContext('2d');
  let w=0,h=0, dpr = Math.max(1, window.devicePixelRatio||1);
  const N = 80;          // jumlah partikel
  const MAX_DIST = 130;  // jarak maksimal tarik garis
  const SPEED = 0.25;    // kecepatan dasar

  const nodes = [];
  function resize(){
    w = cv.clientWidth; h = cv.clientHeight;
    cv.width = Math.floor(w * dpr);
    cv.height= Math.floor(h * dpr);
    ctx.setTransform(dpr,0,0,dpr,0,0);
  }
  window.addEventListener('resize', resize, {passive:true});
  resize();

  // warna ala neon
  const C1 = 'rgba(0,255,255,0.85)';   // cyan
  const C2 = 'rgba(255,77,219,0.85)';  // magenta
  const C3 = 'rgba(255,210,77,0.85)';  // gold

  function rand(a,b){ return a + Math.random()*(b-a); }

  for(let i=0;i<N;i++){
    nodes.push({
      x: rand(0,w), y: rand(0,h),
      vx: rand(-SPEED,SPEED), vy: rand(-SPEED,SPEED),
      r: rand(1.1,2.2),
      c: Math.random()<.45 ? C1 : (Math.random()<.5 ? C2 : C3)
    });
  }

  function step(){
    ctx.clearRect(0,0,w,h);

    // garis antar node
    for(let i=0;i<N;i++){
      const a = nodes[i];
      for(let j=i+1;j<N;j++){
        const b = nodes[j];
        const dx=a.x-b.x, dy=a.y-b.y, d = Math.hypot(dx,dy);
        if(d<MAX_DIST){
          const t = 1 - d/MAX_DIST;
          ctx.globalAlpha = t*0.6;
          // warna campuran ringan
          ctx.strokeStyle = 'rgba(180,210,255,'+(t*0.7)+')';
          ctx.lineWidth = t*1.4;
          ctx.beginPath(); ctx.moveTo(a.x,a.y); ctx.lineTo(b.x,b.y); ctx.stroke();
        }
      }
    }
    ctx.globalAlpha = 1;

    // node (glow)
    for(const n of nodes){
      ctx.shadowColor = n.c;
      ctx.shadowBlur = 8;
      ctx.fillStyle = n.c;
      ctx.beginPath(); ctx.arc(n.x,n.y,n.r,0,Math.PI*2); ctx.fill();
      ctx.shadowBlur = 0;
    }

    // update posisi
    for(const n of nodes){
      n.x += n.vx; n.y += n.vy;
      if(n.x<0 || n.x>w) n.vx*=-1;
      if(n.y<0 || n.y>h) n.vy*=-1;
    }
    requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
})();
