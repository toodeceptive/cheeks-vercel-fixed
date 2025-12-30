# Cheeks Bar & Grill — QR Landing + Event Inquiry Funnel (Vercel)

This repo is a **Vercel-ready** static site with a **production-safe event inquiry form** backed by Vercel Serverless Functions.

## What’s included (current state)
- **index.html** + **styles.css** + **app.js**
- SEO assets: **robots.txt**, **sitemap.xml**, **schema.json**, **site.webmanifest**
- **Event inquiry form** (`#book`) that posts to **/api/inquiry**
- Success flow redirects to **/thank-you.html** (presentation-clean confirmation)
- API endpoints:
  - `GET /api/health` — quick health check
  - `POST /api/inquiry` — validates + logs inquiry + optionally emails owners
  - `POST /api/mark-booked` — internal; emits BOH Event Sheet email (protected)

## Deploy on Vercel
1. Import this repo into Vercel
2. Framework preset: **Other**
3. Build command: **None**
4. Output directory: **/ (root)**
5. Deploy

## Configure environment variables (recommended)
### For owner notification emails (Resend)
- `RESEND_API_KEY` — Resend API key
- `OWNER_NOTIFY_EMAILS` — comma-separated list of owner emails (default: `cheeksbandg@gmail.com`)
- `FROM_EMAIL` — verified sender in Resend (example: `Cheeks Events <noreply@cheeksbar.com>`)

### Optional: customer confirmation email
- `CUSTOMER_CONFIRM` — set to `1` to send an automatic confirmation to the customer’s email (off by default)

### For internal “mark booked” endpoint
- `ADMIN_TOKEN` — long random string

**Call:**
```bash
curl -X POST https://YOUR_DOMAIN.vercel.app/api/mark-booked \
  -H "content-type: application/json" \
  -H "x-admin-token: $ADMIN_TOKEN" \
  -d '{
    "id":"inq_...",
    "name":"...",
    "phone":"...",
    "email":"...",
    "eventType":"...",
    "eventDate":"YYYY-MM-DD",
    "eventTime":"HH:MM",
    "guests":20,
    "package":"B",
    "deposit":"$200",
    "minimumSpend":"$800",
    "notes":"...",
    "src":"van1"
  }'
```

## Inquiry logging
Even with **no email configured**, each inquiry is logged in Vercel function logs as:
- `CHEEKS_INQUIRY {...}`

That makes the funnel demonstrable for the owner presentation even before full integrations.

## Security notes
- Honeypot (`company`) blocks most bots.
- `mark-booked` requires `ADMIN_TOKEN` via the `x-admin-token` header.



## Admin Demo Page (Presentation)
- Open `/admin.html` to generate a BOH Event Sheet preview and/or mark an event as BOOKED (deposit paid) without using curl.
- Requires `ADMIN_TOKEN` set in Vercel env vars.


## Demo (no curl required)
- Open `/admin.html`
- Use **Create Test Inquiry** to generate + submit a sample inquiry
- Use **Preview Event Sheet** then **Mark BOOKED** to demonstrate “deposit paid = booked”

## API Endpoints
- `GET /api/health` — service health
- `POST /api/inquiry` — submit inquiry (logs + optional emails)
- `GET /api/sample-inquiry` — returns a demo payload (for presentation)
- `POST /api/mark-booked` — token-protected “BOOKED” action + BOH event sheet

## Environment Variables
Copy `.env.example` into Vercel env vars.

