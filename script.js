document.getElementById('y').textContent=new Date().getFullYear();
async function loadPrices(){
  try{
    const r=await fetch('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana&vs_currencies=usd');
    const j=await r.json(); const f=n=>'$'+Number(n).toLocaleString(undefined,{maximumFractionDigits:0});
    document.getElementById('btc').textContent=f(j.bitcoin.usd);
    document.getElementById('eth').textContent=f(j.ethereum.usd);
    document.getElementById('sol').textContent=f(j.solana.usd);
  }catch(e){console.warn('price error',e)}
}
loadPrices(); setInterval(loadPrices,60000);
