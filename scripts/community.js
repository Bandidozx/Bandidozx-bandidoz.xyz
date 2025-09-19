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
