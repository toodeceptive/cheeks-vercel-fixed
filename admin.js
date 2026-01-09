/**
 * Admin interface JavaScript
 * Handles event booking and preview functionality
 */
(function(){
  /**
   * Get element by ID
   * @param {string} id - Element ID
   * @returns {HTMLElement|null} Found element or null
   */
  const $ = (id)=>document.getElementById(id);
  const status = $('status');
  const frame = $('previewFrame');

  /**
   * Generate inquiry ID based on current date/time
   * @returns {string} Inquiry ID
   */
  function nowId(){
    const d = new Date();
    const pad = (n)=>String(n).padStart(2,'0');
    return `inq_${d.getFullYear()}${pad(d.getMonth()+1)}${pad(d.getDate())}_${pad(d.getHours())}${pad(d.getMinutes())}${pad(d.getSeconds())}`;
  }

  /**
   * Build payload object from form
   * @param {boolean} preview - Whether this is a preview request
   * @returns {Object} Payload object
   */
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
      guests: Math.max(1, Math.min(200, Number($('guests').value) || 1)),
      package: $('package').value,
      deposit: $('deposit').value.trim(),
      minimumSpend: $('minimumSpend').value.trim(),
      notes: $('notes').value.trim() || '—',
      preview: !!preview
    };
  }

  /**
   * Call mark-booked API endpoint
   * @param {boolean} preview - Whether this is a preview request
   * @returns {Promise<void>}
   */
  async function callMarkBooked(preview){
    if (!status) return;
    status.textContent = 'Working...';
    const token = $('token')?.value?.trim();
    if(!token){
      status.textContent = 'ERROR: ADMIN_TOKEN is required.';
      return;
    }
    const body = payload(preview);
    try{
      const res = await fetch('/api/mark-booked', {
        method:'POST',
        headers:{
          'Content-Type':'application/json; charset=utf-8',
          'x-admin-token': token
        },
        body: JSON.stringify(body)
      });
      let data = {};
      try {
        data = await res.json();
      } catch (jsonErr) {
        status.textContent = 'ERROR: Invalid JSON response';
        return;
      }
      if(!res.ok || !data.ok){
        const errorMsg = data.error || res.statusText || `Request failed (${res.status})`;
        status.textContent = 'ERROR: ' + errorMsg;
        return;
      }
      if(preview){
        const html = data.previewHtml || '';
        if (frame) {
          frame.srcdoc = html || '<p style="font-family:sans-serif;padding:16px">No preview HTML returned.</p>';
        }
        status.textContent = 'Preview generated for ' + body.id;
      }else{
        status.textContent = 'BOOKED marked for ' + body.id + ' — email: ' + (data.email || 'n/a');
      }
    }catch(e){
      const errorMsg = (e && e.message) ? e.message : String(e);
      status.textContent = 'ERROR: ' + errorMsg;
      // eslint-disable-next-line no-console
      console.error('Admin API call error:', e);
    }
  }

  $('previewBtn').addEventListener('click', ()=>callMarkBooked(true));
  $('bookBtn').addEventListener('click', ()=>callMarkBooked(false));

  $('fillBtn')?.addEventListener('click', ()=>{
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    // Use local timezone formatting to avoid UTC conversion issues
    // (e.g., 9 PM PST on Dec 30 should show Dec 31, not Jan 1)
    const y = tomorrow.getFullYear();
    const m = String(tomorrow.getMonth() + 1).padStart(2, '0');
    const d = String(tomorrow.getDate()).padStart(2, '0');
    const dateStr = y + '-' + m + '-' + d;
    
    if ($('src')) $('src').value = 'demo';
    if ($('name')) $('name').value = 'Test Customer';
    if ($('phone')) $('phone').value = '555-555-5555';
    if ($('email')) $('email').value = 'test@example.com';
    if ($('eventType')) $('eventType').value = 'Birthday Party';
    if ($('eventDate')) $('eventDate').value = dateStr;
    if ($('eventTime')) $('eventTime').value = '18:00'; // 24h format for HTML5 time input
    if ($('guests')) $('guests').value = 20;
    if ($('package')) $('package').value = 'B';
    if ($('deposit')) $('deposit').value = '$200';
    if ($('minimumSpend')) $('minimumSpend').value = '$800';
    if ($('notes')) $('notes').value = 'Buffet: wings + curds + fries. One guest gluten-free. Tab: host opens tab.';
    if (status) status.textContent = 'Filled sample. Click Preview or Mark BOOKED.';
  });

  $('clearBtn')?.addEventListener('click', ()=>{
    ['id','src','name','phone','email','eventType','eventDate','eventTime','guests','deposit','minimumSpend','notes'].forEach(k=>{
      const el = $(k);
      if(el) el.value = '';
    });
    const pkgEl = $('package');
    if (pkgEl) pkgEl.value = 'B';
    if (frame) frame.srcdoc = '';
    if (status) status.textContent = '';
  });

})();

