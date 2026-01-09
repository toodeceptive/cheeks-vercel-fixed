/**
 * Shared utility functions for API endpoints
 * Used by: api/inquiry.js, api/mark-booked.js
 */

/**
 * Send error response with status code and message
 * @param {Object} res - Express response object
 * @param {number} code - HTTP status code
 * @param {string} msg - Error message
 * @returns {void}
 */
export function bad(res, code, msg) {
  res.status(code).json({ ok: false, error: msg });
  // Log error for monitoring (intentional console usage for serverless logging)
  // eslint-disable-next-line no-console
  if (code >= 500) {
    // eslint-disable-next-line no-console
    console.error('CHEEKS_API_ERROR', { code, msg, ts: new Date().toISOString() });
  }
}

/**
 * Validate and sanitize string input
 * @param {unknown} v - Input value
 * @param {number} maxLen - Maximum length
 * @returns {string} Sanitized string or empty string
 */
export function requiredStr(v, maxLen) {
  if (typeof v !== 'string') return '';
  const s = v.trim();
  if (!s) return '';
  return s.slice(0, maxLen);
}

/**
 * Validate and sanitize number input
 * @param {unknown} v - Input value
 * @param {number} min - Minimum value
 * @param {number} max - Maximum value
 * @returns {number|null} Valid number or null
 */
export function safeNum(v, min, max) {
  const n = Number(v);
  if (!Number.isFinite(n)) return null;
  if (n < min || n > max) return null;
  return Math.floor(n);
}

/**
 * Escape HTML special characters to prevent XSS
 * @param {string} s - String to escape
 * @returns {string} Escaped string
 */
export function htmlEscape(s) {
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

/**
 * Send email via Resend API
 * @param {Object} params - Email parameters
 * @param {string|string[]} params.to - Recipient email(s)
 * @param {string} params.from - Sender email
 * @param {string} params.subject - Email subject
 * @param {string} params.html - HTML email body
 * @param {string} [params.replyTo] - Reply-to email (optional)
 * @returns {Promise<{sent: boolean, reason?: string, raw?: string}>} Result object with sent status
 */
export async function sendResendEmail({ to, from, subject, html, replyTo }) {
  const apiKey = process.env.RESEND_API_KEY;
  if (!apiKey) return { sent: false, reason: 'RESEND_API_KEY not set' };

  const body = {
    from,
    to: Array.isArray(to) ? to : [to],
    subject,
    html,
  };
  if (replyTo) body.reply_to = replyTo;

  try {
    const r = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json; charset=utf-8'
      },
      body: JSON.stringify(body)
    });

    const text = await r.text();
    if (!r.ok) {
      return { sent: false, reason: `Resend error ${r.status}: ${text.slice(0, 300)}` };
    }
    return { sent: true, raw: text };
  } catch (e) {
    return { sent: false, reason: String(e && e.message ? e.message : e) };
  }
}
