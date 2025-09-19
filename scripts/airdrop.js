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
