
const cfg=window.PANINI_CONFIG||{};
const sb=window.supabase.createClient(cfg.supabaseUrl,cfg.supabaseAnonKey);
const BUCKET="sticker-images";
let rows=[];

const $=x=>document.getElementById(x);
const esc=s=>String(s??"").replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));

function msg(s,bad=false){
  $("msg").textContent=s;
  $("msg").style.borderLeftColor=bad?"var(--red)":"var(--yellow)";
}

async function session(){
  const {data:{session}}=await sb.auth.getSession();
  $("loginBox").classList.toggle("hidden",!!session);
  $("adminBox").classList.toggle("hidden",!session);
  if(session) load();
}

$("login").onclick=async()=>{
  const {error}=await sb.auth.signInWithPassword({
    email:$("email").value.trim(),
    password:$("password").value
  });
  $("loginMsg").textContent=error?error.message:"";
  if(!error) session();
};

$("logout").onclick=async()=>{
  await sb.auth.signOut();
  session();
};

async function load(){
  msg("Loading…");
  const {data,error}=await sb.from("stickers").select("*").order("team").order("number");
  if(error){msg(error.message,true);return}
  rows=data||[];
  fill();
  render();
  msg("Inventory loaded.");
}

function fill(){
  const cur=$("filter").value;
  const teams=[...new Set(rows.map(x=>x.team))].sort();
  $("filter").innerHTML='<option value="">All teams</option>'+teams.map(x=>`<option>${x}</option>`).join("");
  $("filter").value=cur;
}

function render(){
  const q=$("q").value.toLowerCase();
  const f=$("filter").value;
  const d=rows.filter(x=>(!f||x.team===f)&&(`${x.team} ${x.team_name} ${x.player_name||""} ${x.number}`.toLowerCase().includes(q)));

  $("rows").innerHTML=d.map(x=>`
    <tr>
      <td><span class="badge">${esc(x.team)}</span></td>
      <td>${esc(x.team_name)}</td>
      <td>${x.number}</td>
      <td><input id="player-${x.id}" value="${esc(x.player_name||"")}" placeholder="Name"></td>
      <td><input id="qty-${x.id}" type="number" min="1" value="${x.quantity}" style="width:90px"></td>
      <td>
        <div>
          ${x.image_url?`<img class="preview-admin" src="${esc(x.image_url)}" alt="">`:""}
          <input id="img-${x.id}" value="${esc(x.image_url||"")}" placeholder="Image URL">
        </div>
        <div class="file-upload-row">
          <input id="file-${x.id}" type="file" accept="image/jpeg,image/png,image/webp">
          <button class="btn secondary small" onclick="uploadRowPhoto('${x.id}')">Fotoğraf yükle</button>
          ${x.image_url?`<button class="btn danger small" onclick="removeRowPhoto('${x.id}')">Görseli kaldır</button>`:""}
        </div>
      </td>
      <td>
        <div class="row-actions">
          <button class="btn secondary small" onclick="saveRow('${x.id}')">Save</button>
          <button class="btn danger small" onclick="delRow('${x.id}')">Delete</button>
        </div>
      </td>
    </tr>`).join("");
}

function validateImage(file){
  if(!file) return "Önce bir fotoğraf seç.";
  if(!["image/jpeg","image/png","image/webp"].includes(file.type)) return "Sadece JPG, PNG veya WEBP yükleyebilirsin.";
  if(file.size>5*1024*1024) return "Fotoğraf en fazla 5 MB olabilir.";
  return "";
}

function extensionFor(file){
  if(file.type==="image/png") return "png";
  if(file.type==="image/webp") return "webp";
  return "jpg";
}

function storagePathFor(team,number,file){
  const safeTeam=String(team).replace(/[^a-z0-9_-]/gi,"").toUpperCase();
  return `${safeTeam}/${safeTeam}-${number}-${Date.now()}.${extensionFor(file)}`;
}

function storagePathFromPublicUrl(url){
  if(!url) return null;
  const marker=`/storage/v1/object/public/${BUCKET}/`;
  const pos=url.indexOf(marker);
  if(pos===-1) return null;
  return decodeURIComponent(url.slice(pos+marker.length));
}

async function uploadPhoto(file,team,number){
  const problem=validateImage(file);
  if(problem) throw new Error(problem);

  const path=storagePathFor(team,number,file);
  const {error}=await sb.storage.from(BUCKET).upload(path,file,{
    cacheControl:"3600",
    upsert:false,
    contentType:file.type
  });
  if(error) throw error;

  const {data}=sb.storage.from(BUCKET).getPublicUrl(path);
  if(!data?.publicUrl) throw new Error("Görsel adresi oluşturulamadı.");
  return {url:data.publicUrl,path};
}

async function deleteStoredPhoto(url){
  const path=storagePathFromPublicUrl(url);
  if(!path) return;
  const {error}=await sb.storage.from(BUCKET).remove([path]);
  if(error) console.warn("Eski görsel silinemedi:",error.message);
}

$("add").onclick=async()=>{
  const payload={
    team:$("team").value.trim().toUpperCase(),
    team_name:$("name").value.trim(),
    number:Number($("num").value),
    player_name:$("player").value.trim()||null,
    quantity:Number($("qty").value),
    image_url:$("img").value.trim()||null
  };

  if(!payload.team||!payload.team_name||!Number.isInteger(payload.number)||payload.number<1||!Number.isInteger(payload.quantity)||payload.quantity<1){
    msg("Complete all required fields.",true);
    return;
  }

  const file=$("photo").files[0];
  let uploadedPath=null;

  try{
    $("add").classList.add("uploading");
    if(file){
      msg("Fotoğraf yükleniyor…");
      const uploaded=await uploadPhoto(file,payload.team,payload.number);
      payload.image_url=uploaded.url;
      uploadedPath=uploaded.path;
    }

    const {error}=await sb.from("stickers").insert(payload);
    if(error){
      if(uploadedPath) await sb.storage.from(BUCKET).remove([uploadedPath]);
      throw error;
    }

    ["team","name","num","player","img"].forEach(x=>$(x).value="");
    $("photo").value="";
    $("qty").value=1;
    await load();
    msg("Sticker ve fotoğraf eklendi.");
  }catch(error){
    msg(error.message||"İşlem başarısız.",true);
  }finally{
    $("add").classList.remove("uploading");
  }
};

window.uploadRowPhoto=async id=>{
  const row=rows.find(x=>x.id===id);
  const input=$(`file-${id}`);
  const file=input?.files?.[0];
  const problem=validateImage(file);
  if(problem){msg(problem,true);return}

  try{
    msg(`${row.team} ${row.number} fotoğrafı yükleniyor…`);
    const oldUrl=row.image_url;
    const uploaded=await uploadPhoto(file,row.team,row.number);

    const {error}=await sb.from("stickers").update({image_url:uploaded.url}).eq("id",id);
    if(error){
      await sb.storage.from(BUCKET).remove([uploaded.path]);
      throw error;
    }

    await deleteStoredPhoto(oldUrl);
    await load();
    msg("Fotoğraf yüklendi ve sitede güncellendi.");
  }catch(error){
    msg(error.message||"Fotoğraf yüklenemedi.",true);
  }
};

window.removeRowPhoto=async id=>{
  const row=rows.find(x=>x.id===id);
  if(!row||!confirm("Bu sticker görseli kaldırılsın mı?")) return;

  const {error}=await sb.from("stickers").update({image_url:null}).eq("id",id);
  if(error){msg(error.message,true);return}

  await deleteStoredPhoto(row.image_url);
  await load();
  msg("Görsel kaldırıldı.");
};

window.saveRow=async id=>{
  const player_name=$(`player-${id}`).value.trim()||null;
  const quantity=Number($(`qty-${id}`).value);
  const image_url=$(`img-${id}`).value.trim()||null;
  const {error}=await sb.from("stickers").update({player_name,quantity,image_url}).eq("id",id);
  if(error) msg(error.message,true);
  else{await load();msg("Saved.")}
};

window.delRow=async id=>{
  if(!confirm("Delete this sticker?")) return;
  const row=rows.find(x=>x.id===id);
  const {error}=await sb.from("stickers").delete().eq("id",id);
  if(error){msg(error.message,true);return}
  await deleteStoredPhoto(row?.image_url);
  await load();
  msg("Deleted.");
};

$("refresh").onclick=load;
["q","filter"].forEach(x=>$(x).addEventListener("input",render));
sb.auth.onAuthStateChange(()=>session());
session();
