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
