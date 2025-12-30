/**
 * /api/sample-inquiry
 * Generates a deterministic sample inquiry payload for demos.
 * No secrets required. Not indexed. Safe to call.
 */
function json(res, code, obj) {
  res.status(code)
    .setHeader('content-type', 'application/json; charset=utf-8')
    .setHeader('cache-control', 'no-store, no-cache, must-revalidate')
    .setHeader('X-Content-Type-Options', 'nosniff');
  res.end(JSON.stringify(obj));
}

function pick(arr, i) {
  return arr[i % arr.length];
}

export default async function handler(req, res) {
  // Only allow GET requests
  if (req.method !== 'GET') {
    res.setHeader('Allow', 'GET');
    return json(res, 405, { ok: false, error: 'Method not allowed' });
  }
  
  const now = new Date();
  // Create a date 7 days in the future (handles month/year rollovers correctly)
  const futureDate = new Date(now);
  futureDate.setDate(now.getDate() + 7);
  
  const y = futureDate.getFullYear();
  const m = String(futureDate.getMonth() + 1).padStart(2, '0');
  const d = String(futureDate.getDate()).padStart(2, '0');
  
  const sample = {
    name: "Demo Guest",
    phone: "555-555-5555",
    email: "demo@example.com",
    eventType: pick(["Birthday", "Graduation", "Team Party", "Anniversary"], now.getMinutes()),
    eventDate: `${y}-${m}-${d}`,
    eventTime: pick(["16:00", "17:30", "18:00", "19:00"], now.getSeconds()), // Use 24h format for HTML5 time input
    guests: pick([12, 20, 28, 35], now.getMinutes()),
    package: pick(["A", "B", "C"], now.getSeconds()),
    notes: "Demo submission for presentation. Please ignore.",
    src: "demo-admin"
  };
  
  return json(res, 200, { ok: true, sample });
}
