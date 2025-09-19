async function loadData() {
  const airdrop = await fetch("airdrop.json").then(res => res.json());
  const community = await fetch("community.json").then(res => res.json());

  const airdropList = document.getElementById("airdrop-list");
  airdrop.forEach(item => {
    const li = document.createElement("li");
    li.innerHTML = `<a href="${item.link}" target="_blank">${item.name}</a> - ${item.task}`;
    airdropList.appendChild(li);
  });

  const communityList = document.getElementById("community-list");
  community.forEach(item => {
    const li = document.createElement("li");
    li.innerHTML = `<a href="${item.link}" target="_blank">${item.name}</a> - ${item.platform}`;
    communityList.appendChild(li);
  });
}

loadData();
