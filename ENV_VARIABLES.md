# Environment Variables Reference

**Purpose**: Centralized documentation for all environment variables used in the Cheeks Bar & Grill project.

---

## Required Variables

### ADMIN_TOKEN
- **Required**: Yes (for admin endpoints)
- **Type**: String
- **Description**: Authentication token for admin endpoints (`/api/mark-booked`)
- **Usage**: Sent in `x-admin-token` header
- **Security**: Use strong, random token. Store securely in Vercel environment variables.
- **Example**: `your-secure-random-token-here`

---

## Optional Variables

### RESEND_API_KEY
- **Required**: No (email functionality optional)
- **Type**: String
- **Description**: API key for Resend email service
- **Usage**: Used by `api/inquiry.js` and `api/mark-booked.js` for sending emails
- **Where to get**: https://resend.com/api-keys
- **Note**: If not set, system logs to console only (still functional)

### OWNER_NOTIFY_EMAILS
- **Required**: No
- **Type**: Comma-separated string
- **Description**: Email addresses to notify when inquiries/bookings are received
- **Format**: `email1@example.com,email2@example.com`
- **Default**: `cheeksbandg@gmail.com` (if not set)
- **Usage**: Receives inquiry notifications and booking confirmations

### FROM_EMAIL
- **Required**: No (only if RESEND_API_KEY is set)
- **Type**: String
- **Description**: Sender email address for Resend emails
- **Format**: `Name <email@domain.com>` or `email@domain.com`
- **Default**: `Cheeks Events <noreply@cheeksbar.com>` (if not set)
- **Requirement**: Must be verified in Resend dashboard
- **Note**: Domain must be verified in Resend

### CUSTOMER_CONFIRM
- **Required**: No
- **Type**: String (`"1"` to enable, anything else to disable)
- **Description**: Enable customer confirmation emails
- **Default**: Disabled (if not set or not `"1"`)
- **Usage**: When set to `"1"`, sends confirmation email to customer after inquiry submission

---

## Vercel Configuration

### Setting Environment Variables

1. Go to Vercel Dashboard → Your Project → Settings → Environment Variables
2. Add each variable:
   - **Key**: Variable name (e.g., `ADMIN_TOKEN`)
   - **Value**: Variable value
   - **Environment**: Production, Preview, Development (select as needed)
3. Save and redeploy

### Security Best Practices

- ✅ Never commit environment variables to git
- ✅ Use strong, random tokens for `ADMIN_TOKEN`
- ✅ Rotate tokens periodically
- ✅ Use different tokens for production/preview
- ✅ Verify email domains in Resend before using

---

## Variable Summary

| Variable | Required | Default | Purpose |
|----------|----------|---------|---------|
| `ADMIN_TOKEN` | ✅ Yes | None | Admin authentication |
| `RESEND_API_KEY` | ❌ No | None | Email service API key |
| `OWNER_NOTIFY_EMAILS` | ❌ No | `cheeksbandg@gmail.com` | Notification recipients |
| `FROM_EMAIL` | ❌ No | `Cheeks Events <noreply@cheeksbar.com>` | Sender email |
| `CUSTOMER_CONFIRM` | ❌ No | Disabled | Customer confirmation toggle |

---

## Testing Without Email

The system works **fully functional** without email configuration:
- ✅ Form submissions work
- ✅ Data logged to Vercel console
- ✅ Admin endpoints work
- ❌ Email notifications disabled (logs only)

To test email functionality, configure `RESEND_API_KEY` and `FROM_EMAIL`.

---

## Related Documentation

- `README.md` - System overview and setup
- `api/inquiry.js` - Inquiry endpoint implementation
- `api/mark-booked.js` - Booking endpoint implementation

---

**Last Updated**: 2026-01-09  
**Maintained By**: Agent 4 (Configuration & Deployment Guru)
