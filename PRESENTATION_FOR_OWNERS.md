# Cheeks Bar & Grill — Event Inquiry System
## Presentation for Ryan and Angela Thomas

**Date:** December 28, 2025  
**System Status:** ✅ Ready for Production Deployment

---

## What This System Does

This is a **complete event inquiry and booking system** for Cheeks Bar & Grill. Customers can scan a QR code (or click a link) to land on your website, fill out an event inquiry form, and you'll receive their information to follow up and book their event.

### The Complete Flow:

1. **Customer scans QR code** → Lands on your website
2. **Customer fills out event form** → Enters event details (date, time, guests, etc.)
3. **Form submitted** → You receive notification (email or log)
4. **You follow up** → Call customer, confirm details, collect deposit
5. **Mark as BOOKED** → Generate event sheet for kitchen staff
6. **Event happens** → Kitchen has all details ready

---

## Key Features

### ✅ For Customers:
- **Easy to use** - Simple form on mobile or desktop
- **Fast** - Quick loading, works on any device
- **Clear** - Shows what information you need
- **Confirmation** - Shows reference number after submission

### ✅ For You (Owners):
- **Email notifications** - Get notified when someone submits an inquiry
- **Admin dashboard** - Easy interface to mark events as booked
- **Event sheets** - Auto-generated sheets for kitchen staff
- **Source tracking** - See where inquiries come from (QR code, Facebook, etc.)

### ✅ For Kitchen Staff:
- **Event sheets** - Clear, organized sheets with all event details
- **No surprises** - All information in one place
- **Easy to read** - Formatted for quick scanning

---

## How to Use It

### Step 1: Deploy the Website

The website is ready to deploy on Vercel (a free hosting service):

1. Go to [vercel.com](https://vercel.com)
2. Sign up (free)
3. Import this project
4. Click "Deploy"
5. Done! Your website is live

**Your website URL will be:** `https://cheeks-bar-and-grill.vercel.app` (or your custom domain)

### Step 2: Set Up Email Notifications (Optional but Recommended)

1. Sign up for [Resend.com](https://resend.com) (free tier available)
2. Verify your email address
3. Get your API key
4. In Vercel, go to Settings → Environment Variables
5. Add these variables:
   - `RESEND_API_KEY` = your Resend API key
   - `OWNER_NOTIFY_EMAILS` = `cheeksbandg@gmail.com` (or add more, comma-separated)
   - `FROM_EMAIL` = `Cheeks Events <noreply@yourdomain.com>` (must be verified in Resend)

**Note:** The system works WITHOUT email - it logs all inquiries to Vercel function logs. Email just makes it easier to see new inquiries.

### Step 3: Set Up Admin Access

1. In Vercel, go to Settings → Environment Variables
2. Add: `ADMIN_TOKEN` = a long random string (like: `abc123xyz789secret`)
3. Save this token somewhere safe - you'll need it for the admin page

### Step 4: Test It

1. Go to your website
2. Scroll to "Book an Event" section
3. Fill out the form with test data
4. Submit
5. Check your email (or Vercel logs) for the inquiry
6. Go to `/admin.html` on your website
7. Enter your ADMIN_TOKEN
8. Fill in the event details
9. Click "Preview Event Sheet" to see what kitchen staff will see
10. Click "Mark BOOKED" to generate the event sheet email

---

## The Admin Dashboard

**URL:** `https://YOUR_DOMAIN.vercel.app/admin.html`

This is your control panel for managing events. You can:

- **Preview Event Sheets** - See what the kitchen will receive
- **Mark Events as BOOKED** - After deposit is paid, mark it as booked
- **Generate Event Sheets** - Automatically email kitchen staff

**Security:** This page is protected - you need your ADMIN_TOKEN to use it. It's also hidden from search engines.

---

## How Customers Use It

### Option 1: QR Code
1. Print QR code on table tents, flyers, or business cards
2. Customer scans with phone
3. Lands on your website
4. Fills out form
5. Done!

### Option 2: Direct Link
1. Share link on Facebook, website, or email
2. Customer clicks link
3. Lands on your website
4. Fills out form
5. Done!

**The form tracks where customers came from** (QR code, Facebook, etc.) so you can see what marketing works.

---

## What Information You'll Receive

For each inquiry, you'll get:

- **Customer Name**
- **Phone Number**
- **Email Address**
- **Event Type** (Birthday, Graduation, etc.)
- **Event Date**
- **Start Time**
- **Number of Guests**
- **Package Preference** (A, B, or C)
- **Special Notes** (dietary needs, requests, etc.)
- **Source** (where they came from - QR code, Facebook, etc.)
- **Reference ID** (unique ID for tracking)

---

## The Booking Process

### When You Receive an Inquiry:

1. **Check your email** (or Vercel logs) for new inquiry
2. **Call the customer** - Use the phone number provided
3. **Confirm details** - Verify date, time, guest count
4. **Discuss package** - Confirm which package they want
5. **Collect deposit** - For groups of 13+, collect deposit
6. **Mark as BOOKED** - Use admin page to mark event as booked
7. **Event sheet generated** - Kitchen staff automatically receive event sheet

### The Event Sheet Includes:

- Event status (BOOKED - deposit paid)
- Event type and date
- Start time
- Number of guests
- Package
- Deposit amount
- Minimum spend
- Customer contact info
- Special notes/requests
- Source (where inquiry came from)

---

## Important Notes

### ✅ What Works Right Now:
- Form submission ✅
- Inquiry logging ✅
- Email notifications (if configured) ✅
- Admin dashboard ✅
- Event sheet generation ✅
- Source tracking ✅
- Mobile-friendly design ✅

### ⚠️ What's Optional:
- **Gallery images** - The gallery section works, but you can add photos later (see ADD_IMAGES.md)
- **Email notifications** - System works without email (logs to Vercel)
- **Customer confirmation emails** - Can be enabled if you want

### 🔒 Security:
- Bot protection (honeypot field)
- Input validation (prevents bad data)
- Admin token protection
- Secure headers (protects against attacks)

---

## Support & Questions

### If Something Doesn't Work:

1. **Check Vercel logs** - All inquiries are logged there
2. **Check email** - If emails aren't sending, check Resend dashboard
3. **Test admin page** - Make sure ADMIN_TOKEN is correct
4. **Check form** - Try submitting a test inquiry

### Common Issues:

**"Emails aren't sending"**
- Check RESEND_API_KEY is set correctly
- Check FROM_EMAIL is verified in Resend
- System still works - check Vercel logs instead

**"Admin page says unauthorized"**
- Check ADMIN_TOKEN is set in Vercel
- Make sure you're entering it correctly
- Token is case-sensitive

**"Form won't submit"**
- Check all required fields are filled
- Check date is in the future
- Check guest count is 1-200
- Check browser console for errors

---

## Next Steps

1. **Deploy to Vercel** - Get your website live
2. **Set up email** - Configure Resend (optional)
3. **Set admin token** - Secure your admin page
4. **Test everything** - Submit a test inquiry
5. **Create QR codes** - Print and place around restaurant
6. **Share on Facebook** - Post the link
7. **Start receiving inquiries!**

---

## Technical Details (For Reference)

- **Hosting:** Vercel (free tier available)
- **Email Service:** Resend (free tier: 3,000 emails/month)
- **Form Validation:** Client-side and server-side
- **Security:** Honeypot, input sanitization, token protection
- **Mobile:** Fully responsive, works on all devices
- **SEO:** Complete meta tags, structured data, sitemap
- **Performance:** Optimized for speed
- **Accessibility:** WCAG compliant

---

## Questions?

If you have any questions about using the system, setting it up, or need help with anything, the system creator can help you.

**The system is ready to use right now!** Just deploy it and start receiving event inquiries.

---

**System Status:** ✅ Production-ready, fully tested, optimized  
**Last Updated:** December 28, 2025

