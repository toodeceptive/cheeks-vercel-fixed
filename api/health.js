/**
 * /api/health
 * Simple health check endpoint for monitoring and uptime checks.
 * Returns service status and timestamp.
 */
export default async function handler(req, res) {
  res.setHeader('content-type', 'application/json; charset=utf-8');
  res.setHeader('cache-control', 'no-store, no-cache, must-revalidate');
<<<<<<< Current (Your changes)
  res.status(200).end(JSON.stringify({
    ok: true,
    service: 'cheeks-event-funnel',
    ts: new Date().toISOString()
=======
  res.status(200).end(JSON.stringify({ 
    ok: true, 
    service: 'cheeks-event-funnel', 
    ts: new Date().toISOString(),
    uptime: process.uptime ? Math.floor(process.uptime()) : null
>>>>>>> Incoming (Background Agent changes)
  }));
}
