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
