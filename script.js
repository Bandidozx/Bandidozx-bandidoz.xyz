/* ========= LINKS ========= */
(() => {
  const L = (window.__LINKS__||{});
  const byId = id => document.getElementById(id);
  const idToUrl = { "lnk-x":L.x, "lnk-gh":L.gh, "lnk-in":L.in, "lnk-dc":L.dc };
  Object.entries(idToUrl).forEach(([id,url])=>{
    const el = byId(id); if(el && url){ el.href = url; el.target = "_blank"; }
  });
  const ad = byId('btn-airdrop'), cm = byId('btn-community');
  if(ad && L.airdrop){ ad.href = L.airdrop; ad.target = "_blank"; }
  if(cm && L.community){ cm.href = L.community; cm.target = "_blank"; }
  const y=document.getElementById('year'); if(y) y.textContent = new Date().getFullYear();
})();

/* ========= SIMPLE TICKER (CoinGecko public API) ========= */
async function fetchSnapshot(){
  try{
    const ids = 'bitcoin,ethereum,solana';
    const url='https://api.coingecko.com/api/v3/simple/price?ids='+ids+'&vs_currencies=usd&include_24hr_change=true';
    const r = await fetch(url,{cache:'no-store'});
    const j = await r.json();
    const fmt=(n)=>'$'+n.toLocaleString(undefined,{maximumFractionDigits:0});
    const pct=(x)=>((x>0?'+':'')+x.toFixed(2)+'%');
    const row = [
      `BTC: ${fmt(j.bitcoin.usd)}  24h: ${pct(j.bitcoin.usd_24h_change)}`,
      `ETH: ${fmt(j.ethereum.usd)}  24h: ${pct(j.ethereum.usd_24h_change)}`,
      `SOL: ${fmt(j.solana.usd)}  24h: ${pct(j.solana.usd_24h_change)}`
    ].join('   •   ');
    const t = document.getElementById('ticker');
    if(t) t.textContent = row + '   •   updated ' + new Date().toLocaleTimeString();
  }catch(e){
    const t = document.getElementById('ticker');
    if(t) t.textContent = 'Snapshot unavailable (rate-limit / network).';
  }
}
fetchSnapshot();
setInterval(fetchSnapshot, 90_000);

/* ========= CONSTELLATION BACKGROUND ========= */
(function runBg(){
  const c = document.getElementById('bg'); const ctx = c.getContext('2d');
  let W,H; const DPR=window.devicePixelRatio||1;
  function resize(){ W=window.innerWidth; H=window.innerHeight; c.width=W*DPR; c.height=H*DPR; c.style.width=W+'px'; c.style.height=H+'px'; ctx.setTransform(DPR,0,0,DPR,0,0); }
  resize(); window.addEventListener('resize', resize);

  const N = 120, P=[];
  for(let i=0;i<N;i++){
    P.push({x:Math.random()*W,y:Math.random()*H,vx:(Math.random()-0.5)*.3,vy:(Math.random()-0.5)*.3});
  }
  function step(){
    ctx.clearRect(0,0,W,H);
    for(const p of P){
      p.x+=p.vx; p.y+=p.vy;
      if(p.x<0||p.x>W) p.vx*=-1;
      if(p.y<0||p.y>H) p.vy*=-1;
      ctx.fillStyle = 'rgba(94,243,255,.85)';
      ctx.beginPath(); ctx.arc(p.x,p.y,1.2,0,Math.PI*2); ctx.fill();
    }
    ctx.strokeStyle='rgba(94,243,255,.08)';
    for(let i=0;i<N;i++) for(let j=i+1;j<N;j++){
      const a=P[i],b=P[j]; const dx=a.x-b.x, dy=a.y-b.y; const d=dx*dx+dy*dy;
      if(d<120*120){ ctx.globalAlpha = 1 - d/(120*120); ctx.beginPath(); ctx.moveTo(a.x,a.y); ctx.lineTo(b.x,b.y); ctx.stroke(); ctx.globalAlpha=1; }
    }
    requestAnimationFrame(step);
  }
  step();
})();
