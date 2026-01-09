/**
 * /api/health
 * Simple health check endpoint for monitoring and uptime checks.
 * Returns service status and timestamp.
 * @param {Object} req - Request object
 * @param {Object} res - Response object
 * @returns {Promise<void>}
 */
export default async function handler(req, res) {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.setHeader('cache-control', 'no-store, no-cache, must-revalidate');
  res.status(200).end(JSON.stringify({ 
    ok: true, 
    service: 'cheeks-event-funnel', 
    ts: new Date().toISOString(),
    uptime: process.uptime ? Math.floor(process.uptime()) : null
  }));
}
