(() => {
  const L=(window.__LINKS__||{}), byId=id=>document.getElementById(id);
  const map={ "lnk-x":L.x, "lnk-gh":L.gh, "lnk-in":L.in, "lnk-dc":L.dc };
  Object.entries(map).forEach(([id,url])=>{const el=byId(id); if(el&&url){ el.href=url; el.target="_blank"; }});
  const ad=byId('btn-airdrop'), cm=byId('btn-community');
  if(ad&&L.airdrop){ ad.href=L.airdrop; ad.target="_blank"; }
  if(cm&&L.community){ cm.href=L.community; cm.target="_blank"; }
  const y=byId('year'); if(y) y.textContent=new Date().getFullYear();
})();

async function fetchSnapshot(){
  try{
    const ids='bitcoin,ethereum,solana';
    const r=await fetch('https://api.coingecko.com/api/v3/simple/price?ids='+ids+'&vs_currencies=usd&include_24hr_change=true',{cache:'no-store'});
    const j=await r.json(), fmt=n=>'$'+n.toLocaleString(undefined,{maximumFractionDigits:0}), pct=x=>((x>0?'+':'')+x.toFixed(2)+'%');
    const row=[
      `BTC: ${fmt(j.bitcoin.usd)}  24h: ${pct(j.bitcoin.usd_24h_change)}`,
      `ETH: ${fmt(j.ethereum.usd)}  24h: ${pct(j.ethereum.usd_24h_change)}`,
      `SOL: ${fmt(j.solana.usd)}  24h: ${pct(j.solana.usd_24h_change)}`
    ].join('   •   ');
    const t=document.getElementById('ticker'); if(t) t.textContent=row+'   •   updated '+new Date().toLocaleTimeString();
  }catch(e){ const t=document.getElementById('ticker'); if(t) t.textContent='Snapshot unavailable.'; }
}
fetchSnapshot(); setInterval(fetchSnapshot, 90000);

(function bg(){
  const c=document.getElementById('bg'), ctx=c.getContext('2d'); let W,H; const DPR=window.devicePixelRatio||1;
  function rs(){W=innerWidth;H=innerHeight;c.width=W*DPR;c.height=H*DPR;c.style.width=W+'px';c.style.height=H+'px';ctx.setTransform(DPR,0,0,DPR,0,0)}
  rs(); addEventListener('resize',rs);
  const N=120,P=[]; for(let i=0;i<N;i++) P.push({x:Math.random()*W,y:Math.random()*H,vx:(Math.random()-.5)*.3,vy:(Math.random()-.5)*.3});
  function step(){
    ctx.clearRect(0,0,W,H);
    for(const p of P){ p.x+=p.vx;p.y+=p.vy; if(p.x<0||p.x>W)p.vx*=-1; if(p.y<0||p.y>H)p.vy*=-1;
      ctx.fillStyle='rgba(94,243,255,.85)';ctx.beginPath();ctx.arc(p.x,p.y,1.2,0,Math.PI*2);ctx.fill();}
    ctx.strokeStyle='rgba(94,243,255,.08)';
    for(let i=0;i<N;i++)for(let j=i+1;j<N;j++){const a=P[i],b=P[j],dx=a.x-b.x,dy=a.y-b.y,d=dx*dx+dy*dy;
      if(d<120*120){ctx.globalAlpha=1-d/(120*120);ctx.beginPath();ctx.moveTo(a.x,a.y);ctx.lineTo(b.x,b.y);ctx.stroke();ctx.globalAlpha=1;}}
    requestAnimationFrame(step);
  } step();
})();

/* === Dynamic Market Ticker === */
async function loadTicker() {
  try {
    const res = await fetch("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd&include_24hr_change=true");
    const data = await res.json();

    const btc = data.bitcoin.usd;
    const btcChg = data.bitcoin.usd_24h_change.toFixed(2);

    const eth = data.ethereum.usd;
    const ethChg = data.ethereum.usd_24h_change.toFixed(2);

    const sol = data.solana.usd;
    const solChg = data.solana.usd_24h_change.toFixed(2);

    function spanPrice(label, price, chg) {
      const color = chg < 0 ? "red" : "limegreen";
      return `${label}: $${price.toLocaleString()} <span style="color:${color}">${chg}%</span>`;
    }

    document.getElementById("ticker").innerHTML = `
      ${spanPrice("BTC", btc, btcChg)} &nbsp;&nbsp;
      ${spanPrice("ETH", eth, ethChg)} &nbsp;&nbsp;
      ${spanPrice("SOL", sol, solChg)} 
      <small style="opacity:.6">updated ${new Date().toLocaleTimeString()}</small>
    `;
  } catch (e) {
    document.getElementById("ticker").textContent = "Error loading prices ⚠️";
  }
}

loadTicker();
setInterval(loadTicker, 60000);
