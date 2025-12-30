(function(){
  const $ = (id)=>document.getElementById(id);
  const status = $('status');
  const frame = $('previewFrame');

  function nowId(){
    const d = new Date();
    const pad = (n)=>String(n).padStart(2,'0');
    return `inq_${d.getFullYear()}${pad(d.getMonth()+1)}${pad(d.getDate())}_${pad(d.getHours())}${pad(d.getMinutes())}${pad(d.getSeconds())}`;
  }

  function payload(preview){
    const id = $('id').value.trim() || nowId();
    $('id').value = id;
    return {
      id,
      src: ($('src').value.trim() || 'demo'),
      name: $('name').value.trim(),
      phone: $('phone').value.trim(),
      email: $('email').value.trim(),
      eventType: $('eventType').value.trim(),
      eventDate: $('eventDate').value.trim(),
      eventTime: $('eventTime').value.trim(),
      guests: Number($('guests').value || 0),
      package: $('package').value,
      deposit: $('deposit').value.trim(),
      minimumSpend: $('minimumSpend').value.trim(),
      notes: $('notes').value.trim() || '—',
      preview: !!preview
    };
  }

  async function callMarkBooked(preview){
    status.textContent = 'Working...';
    const token = $('token').value.trim();
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:33',message:'Admin call start',data:{preview,hasToken:!!token},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
    // #endregion
    if(!token){
      status.textContent = 'ERROR: ADMIN_TOKEN is required.';
      return;
    }
    const body = payload(preview);
    // #region agent log
    fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:40',message:'Admin payload created',data:{id:body.id,hasName:!!body.name,hasEmail:!!body.email},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
    // #endregion
    try{
      const res = await fetch('/api/mark-booked', {
        method:'POST',
        headers:{
          'content-type':'application/json',
          'x-admin-token': token
        },
        body: JSON.stringify(body)
      });
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:50',message:'Admin response received',data:{status:res.status,ok:res.ok},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
      // #endregion
      const data = await res.json().catch(()=>({}));
      if(!res.ok || !data.ok){
        status.textContent = 'ERROR: ' + (data.error || res.statusText || 'Request failed');
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:52',message:'Admin error',data:{error:data.error},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
        // #endregion
        return;
      }
      if(preview){
        const html = data.previewHtml || '';
        frame.srcdoc = html || '<p style="font-family:sans-serif;padding:16px">No preview HTML returned.</p>';
        status.textContent = 'Preview generated for ' + body.id;
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:56',message:'Preview success',data:{hasHtml:!!html},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
        // #endregion
      }else{
        status.textContent = 'BOOKED marked for ' + body.id + ' — email: ' + (data.email || 'n/a');
        // #region agent log
        fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:60',message:'Booked success',data:{email:data.email},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
        // #endregion
      }
    }catch(e){
      status.textContent = 'ERROR: ' + (e && e.message ? e.message : String(e));
      // #region agent log
      fetch('http://127.0.0.1:7242/ingest/57b299a8-4574-40ad-8d61-9a9b5885b3f1',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({location:'admin.js:63',message:'Admin exception',data:{error:String(e)},timestamp:Date.now(),sessionId:'debug-session',runId:'run1',hypothesisId:'G'})}).catch(()=>{});
      // #endregion
    }
  }

  $('previewBtn').addEventListener('click', ()=>callMarkBooked(true));
  $('bookBtn').addEventListener('click', ()=>callMarkBooked(false));

  $('fillBtn').addEventListener('click', ()=>{
    $('src').value = 'demo';
    $('name').value = 'Test Customer';
    $('phone').value = '555-555-5555';
    $('email').value = 'test@example.com';
    $('eventType').value = 'Birthday Party';
    $('eventDate').value = '2026-01-17';
    $('eventTime').value = '6:00 PM';
    $('guests').value = 20;
    $('package').value = 'B';
    $('deposit').value = '$200';
    $('minimumSpend').value = '$800';
    $('notes').value = 'Buffet: wings + curds + fries. One guest gluten-free. Tab: host opens tab.';
    status.textContent = 'Filled sample. Click Preview or Mark BOOKED.';
  });

  $('clearBtn').addEventListener('click', ()=>{
    ['id','src','name','phone','email','eventType','eventDate','eventTime','guests','deposit','minimumSpend','notes'].forEach(k=>{
      const el = $(k);
      if(el) el.value = '';
    });
    $('package').value='B';
    frame.srcdoc = '';
    status.textContent = '';
  });

})();


function fillForm(p) {
  for (const [k,v] of Object.entries(p||{})) {
    const el = document.querySelector(`[name="${k}"]`) || document.getElementById(k);
    if (el) el.value = v;
  }
}
function readForm() {
  const fields = ['name','phone','email','eventType','eventDate','eventTime','guests','package','notes','src','deposit','minimumSpend','id'];
  const out = {};
  for (const k of fields) {
    const el = document.querySelector(`[name="${k}"]`) || document.getElementById(k);
    if (el && el.value !== undefined) out[k] = el.value;
  }
  if (out.guests) out.guests = Number(out.guests);
  return out;
}



// --- Demo helpers added for presentation (no curl required) ---
const $last = document.getElementById('lastResponse');
function setLast(obj) {
  if (!$last) return;
  $last.textContent = JSON.stringify(obj, null, 2);
}
async function apiJson(path, opts={}) {
  const res = await fetch(path, opts);
  const data = await res.json().catch(() => ({ ok:false, error:"Invalid JSON" }));
  setLast({ status: res.status, path, data });
  return { res, data };
}

const btnCreate = document.getElementById('btnCreateTest');
if (btnCreate) btnCreate.addEventListener('click', async () => {
  // Get a fresh sample payload, then submit it to /api/inquiry
  const s = await apiJson('/api/sample-inquiry');
  if (!s.data || !s.data.ok) return alert('Could not get sample payload');
  const payload = s.data.sample;
  // Fill UI with the sample payload for transparency
  fillForm(payload);
  const result = await apiJson('/api/inquiry', {
    method: 'POST',
    headers: { 'content-type': 'application/json; charset=utf-8' },
    body: JSON.stringify(payload)
  });
  if (result.data && result.data.ok) {
    alert('Test inquiry created. Scroll to Last API Response.');
  }
});

const btnCopy = document.getElementById('btnCopyJson');
if (btnCopy) btnCopy.addEventListener('click', async () => {
  const payload = readForm();
  try {
    await navigator.clipboard.writeText(JSON.stringify(payload, null, 2));
    alert('Inquiry JSON copied to clipboard.');
  } catch (e) {
    alert('Copy failed. You can manually copy from the form.');
  }
});

