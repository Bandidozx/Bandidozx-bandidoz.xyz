const pageSize=10; let data=[],page=1;
const $=s=>document.querySelector(s); const params=new URLSearchParams(location.search);
const tab=params.get('tab')||'free';
async function load(){const r=await fetch('data/airdrop.json');const all=await r.json();data=all.filter(x=>tab==='paid'?x.paid:(tab==='ended'?x.ended:!x.paid&&!x.ended));bind();}
function bind(){$('#q').addEventListener('input',render);$('#filter').addEventListener('change',render);
$('#prev').addEventListener('click',()=>{if(page>1){page--;render();}});$('#next').addEventListener('click',()=>{if(page<Math.ceil(filtered().length/pageSize)){page++;render();}});render();}
function tagBadge(t){const c=t==='TESTNET'?'red':t==='SOCIAL'?'purple':t==='DEPIN'?'green':'gray';return `<span class="tag ${c}">${t}</span>`}
function filtered(){const q=$('#q').value.trim().toLowerCase();const f=$('#filter').value;return data.filter(x=>(f==='ALL'||x.tag===f)&&(x.name.toLowerCase().includes(q)));}
function render(){const arr=filtered();const total=Math.ceil(arr.length/pageSize);if(page>total)page=total||1;const start=(page-1)*pageSize;const slice=arr.slice(start,start+pageSize);
$('#rows').innerHTML=slice.map(x=>`<div class="list-row"><div class="name">${x.name}</div><div>${tagBadge(x.tag)}</div><div class="right"><a class="btn small" href="${x.url}" target="_blank">Visit</a></div></div>`).join('');
$('#page').textContent=page;}
load();
