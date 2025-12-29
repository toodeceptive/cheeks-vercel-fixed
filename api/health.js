export default async function handler(req, res) {
  res.setHeader('content-type', 'application/json');
  res.status(200).end(JSON.stringify({ ok: true, service: 'cheeks-event-funnel', ts: new Date().toISOString() }));
}
