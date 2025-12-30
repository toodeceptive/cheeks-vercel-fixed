# How to View Tracking Data — Owner Guide

## Current Tracking System

The system tracks all inquiries and bookings, but you need to know where to look.

---

## 1. Viewing Inquiries (Vercel Logs)

### Method 1: Vercel Dashboard (Recommended)

1. Go to: https://vercel.com/dashboard
2. Select your project: "cheeks-bar-and-grill"
3. Click "Functions" tab
4. Click on `/api/inquiry` function
5. Click "Logs" tab
6. Look for: `CHEEKS_INQUIRY {...}`

**What You'll See:**
```json
CHEEKS_INQUIRY {
  "id": "inq_1234567890_abc123",
  "ts": "2025-12-28T10:30:00.000Z",
  "name": "John Doe",
  "phone": "715-555-1234",
  "email": "john@example.com",
  "eventType": "Birthday",
  "eventDate": "2026-01-15",
  "eventTime": "18:00",
  "package": "B",
  "guests": 20,
  "notes": "Gluten-free options needed",
  "src": "qr-table-tent",
  "status": "NEW"
}
```

### Method 2: Email Notifications (If Configured)

If you set up email notifications:
- Check your email (cheeksbandg@gmail.com)
- You'll receive an email for each inquiry
- Email includes all customer details
- Source is shown in email

---

## 2. Viewing Bookings (Vercel Logs)

### Method 1: Vercel Dashboard

1. Go to: https://vercel.com/dashboard
2. Select your project
3. Click "Functions" tab
4. Click on `/api/mark-booked` function
5. Click "Logs" tab
6. Look for: `CHEEKS_BOOKED {...}`

**What You'll See:**
```json
CHEEKS_BOOKED {
  "id": "inq_1234567890_abc123",
  "ts": "2025-12-28T11:00:00.000Z",
  "name": "John Doe",
  "phone": "715-555-1234",
  "email": "john@example.com",
  "eventType": "Birthday",
  "eventDate": "2026-01-15",
  "eventTime": "18:00",
  "guests": "20",
  "package": "B",
  "deposit": "$200",
  "minimumSpend": "$800",
  "status": "BOOKED"
}
```

### Method 2: Email Notifications

When you mark an event as BOOKED:
- Event sheet email sent to owners (for kitchen)
- Check your email for event sheet

---

## 3. Tracking Sources

### What Sources Are Tracked:

- **QR Code (Table Tent):** `src: "qr-table-tent"`
- **QR Code (Flyer):** `src: "qr-flyer"`
- **QR Code (Business Card):** `src: "qr-business-card"`
- **Facebook:** `src: "facebook"` or `utm_source: "facebook"`
- **Direct:** `src: "direct"` (default, no source parameter)

### How to See Source Data:

1. Go to Vercel logs (see above)
2. Look at `CHEEKS_INQUIRY` logs
3. Find `"src"` field in JSON
4. Count inquiries by source

**Example:**
- 10 inquiries with `"src":"qr-table-tent"`
- 5 inquiries with `"src":"facebook"`
- 3 inquiries with `"src":"direct"`

---

## 4. Tracking Conversion (Inquiry → Booking)

### Current Method (Manual):

1. Get inquiry ID from `CHEEKS_INQUIRY` log
2. Search `CHEEKS_BOOKED` logs for same ID
3. If found, inquiry became booking
4. Calculate: (Bookings / Inquiries) × 100 = Conversion Rate

**Example:**
- 20 inquiries total
- 8 bookings (same IDs found in BOOKED logs)
- Conversion rate: (8/20) × 100 = 40%

### Limitations:

- ❌ No automatic linking
- ❌ Must manually match IDs
- ❌ No dashboard to see this
- ❌ Time-consuming

**Future:** Dashboard will show this automatically

---

## 5. Exporting Data

### Current Method (Manual):

1. Go to Vercel logs
2. Copy JSON data
3. Paste into text file
4. Use JSON to CSV converter (online tool)
5. Open in Excel/Google Sheets

### Limitations:

- ❌ No export button
- ❌ Must copy/paste manually
- ❌ Time-consuming

**Future:** Dashboard will have export button

---

## 6. What We DON'T Track (Yet)

❌ **QR Code Scans (Without Form Submission)**
- We only track if customer submits form
- Can't see: "100 scans, 10 inquiries"

❌ **Page Views by Source**
- Can't see how many people visited from each source
- Only see form submissions

❌ **Time to Booking**
- Can't see how long between inquiry and booking
- Must calculate manually

❌ **Revenue Estimates**
- Can't see estimated revenue per event
- Must calculate manually

---

## 7. Quick Reference

### Log Patterns to Search:

- `CHEEKS_INQUIRY` - New inquiry
- `CHEEKS_BOOKED` - Event marked as booked
- `CHEEKS_HONEYPOT` - Bot detected (ignore)
- `CHEEKS_API_ERROR` - Error occurred
- `CHEEKS_EMAIL_ERR` - Email error

### Key Fields:

- `id` - Unique inquiry/booking ID
- `src` - Source (where they came from)
- `status` - "NEW" (inquiry) or "BOOKED" (booking)
- `ts` - Timestamp
- `guests` - Number of guests
- `package` - Package (A, B, or C)

---

## 8. Tips for Owners

### Daily Check:
1. Check email for new inquiries (if configured)
2. Or check Vercel logs once per day
3. Call customers within 24 hours
4. Mark as BOOKED after deposit paid

### Weekly Review:
1. Count total inquiries
2. Count total bookings
3. Calculate conversion rate
4. See which sources are most effective
5. Adjust marketing based on data

### Monthly Analysis:
1. Export data to spreadsheet
2. Calculate average party size
3. Calculate revenue estimates
4. See trends over time
5. Plan marketing strategy

---

**Status:** Current system works, but requires manual work  
**Future:** Dashboard will make this easier

