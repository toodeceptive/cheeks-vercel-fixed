/**
 * Simple in-memory rate limiting for Vercel serverless functions
 * Note: This is per-instance, not shared across instances
 * For production, consider using Vercel's built-in rate limiting or external service
 */

// In-memory store (cleared on cold start)
const requestCounts = new Map();

/**
 * Rate limit configuration
 */
const RATE_LIMIT_CONFIG = {
  windowMs: 60 * 1000, // 1 minute
  maxRequests: 10, // 10 requests per minute per IP
};

/**
 * Clean up old entries periodically
 */
function cleanup() {
  const now = Date.now();
  for (const [key, data] of requestCounts.entries()) {
    if (now - data.windowStart > RATE_LIMIT_CONFIG.windowMs) {
      requestCounts.delete(key);
    }
  }
}

/**
 * Check if request should be rate limited
 * @param {string} identifier - Unique identifier (typically IP address)
 * @returns {{allowed: boolean, remaining: number, resetAt: number}} Rate limit result
 */
export function checkRateLimit(identifier) {
  const now = Date.now();
  const key = identifier || 'unknown';
  
  // Clean up old entries
  cleanup();
  
  const data = requestCounts.get(key);
  
  if (!data) {
    // First request from this IP
    requestCounts.set(key, {
      count: 1,
      windowStart: now,
    });
    return {
      allowed: true,
      remaining: RATE_LIMIT_CONFIG.maxRequests - 1,
      resetAt: now + RATE_LIMIT_CONFIG.windowMs,
    };
  }
  
  // Check if window has expired
  if (now - data.windowStart > RATE_LIMIT_CONFIG.windowMs) {
    // Start new window
    requestCounts.set(key, {
      count: 1,
      windowStart: now,
    });
    return {
      allowed: true,
      remaining: RATE_LIMIT_CONFIG.maxRequests - 1,
      resetAt: now + RATE_LIMIT_CONFIG.windowMs,
    };
  }
  
  // Increment count
  data.count++;
  
  if (data.count > RATE_LIMIT_CONFIG.maxRequests) {
    return {
      allowed: false,
      remaining: 0,
      resetAt: data.windowStart + RATE_LIMIT_CONFIG.windowMs,
    };
  }
  
  return {
    allowed: true,
    remaining: RATE_LIMIT_CONFIG.maxRequests - data.count,
    resetAt: data.windowStart + RATE_LIMIT_CONFIG.windowMs,
  };
}

/**
 * Get client IP address from request
 * @param {Object} req - Request object
 * @returns {string} IP address
 */
export function getClientIP(req) {
  // Vercel provides x-forwarded-for header
  const forwarded = req.headers['x-forwarded-for'];
  if (forwarded) {
    // x-forwarded-for can contain multiple IPs, take the first one
    return forwarded.split(',')[0].trim();
  }
  
  // Fallback to x-real-ip
  const realIP = req.headers['x-real-ip'];
  if (realIP) {
    return realIP.trim();
  }
  
  return 'unknown';
}
