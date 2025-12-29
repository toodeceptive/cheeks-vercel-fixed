/**
 * /api/sample-inquiry
 * Generates a deterministic sample inquiry payload for demos.
 * No secrets required. Not indexed. Safe to call.
 */
function json(res, code, obj) {
  res.status(code).setHeader('content-type', 'application/json; charset=utf-8');
  res.end(JSON.stringify(obj));
}
function pick(arr, i) { return arr[i % arr.length]; }
module.exports = async (req, res) => {
  const now = new Date();
  const y = now.getFullYear();
  const m = String(now.getMonth()+1).padStart(2,'0');
  const d = String(Math.min(now.getDate()+7, 28)).padStart(2,'0');
  const sample = {
    name: "Demo Guest",
    phone: "555-555-5555",
    email: "demo@example.com",
    eventType: pick(["Birthday", "Graduation", "Team Party", "Anniversary"], now.getMinutes()),
    eventDate: `${y}-${m}-${d}`,
    eventTime: pick(["4:00 PM","5:30 PM","6:00 PM","7:00 PM"], now.getSeconds()),
    guests: pick([12, 20, 28, 35], now.getMinutes()),
    package: pick(["A","B","C"], now.getSeconds()),
    notes: "Demo submission for presentation. Please ignore.",
    src: "demo-admin"
  };
  return json(res, 200, { ok: true, sample });
};
