# Personal Notes & Reference — Cody
**For:** System Presentation, Pricing, Planning, Customer Experience, Functional Dynamics, Logs  
**Date:** December 28, 2025  
**Status:** Research & Planning Document

---

## SYSTEM OVERVIEW — PRESENTATION TALKING POINTS

### What This System Does (Owner Presentation)
1. **QR Code → Landing Page** - Customer scans, lands on beautiful mobile-optimized page
2. **Event Inquiry Form** - Customer fills out event details (date, time, guests, package preference)
3. **Owner Notification** - You receive email/log with all customer details
4. **Follow-Up** - You call customer, confirm details, collect deposit
5. **Mark as BOOKED** - Use admin page to mark event as booked (deposit paid)
6. **Event Sheet Generation** - Kitchen automatically receives organized event sheet
7. **Event Execution** - Kitchen has all details, no surprises

### Key Value Propositions
- **Reduces BOH Chaos** - Pre-booked events = better prep, less stress
- **Protects Small Kitchen** - Deposit requirement reduces cancellations
- **Saves Time** - Automated inquiry intake, organized event sheets
- **Professional Image** - Modern, mobile-friendly booking system
- **Source Tracking** - See where inquiries come from (QR, Facebook, etc.)

### System Architecture (Technical - For Your Reference)
- **Frontend:** Static HTML/CSS/JS (fast, reliable, no server costs)
- **Backend:** Vercel serverless functions (scales automatically)
- **Email:** Resend integration (optional, works without it)
- **Security:** Honeypot, input validation, token protection
- **Hosting:** Vercel (free tier available, scales as needed)

---

## PRICING RESEARCH & COMPENSATION MODELS

### Research Sources Needed:
1. Event coordinator salaries (WI/Wausau-adjusted)
2. Landing page development pricing
3. Event sales commission norms
4. Restaurant event booking SaaS pricing
5. Deposit policy best practices

### Compensation Model Options:

#### Model 1: Setup + Retainer
- **Setup Fee:** $X,XXX (one-time)
- **Monthly Retainer:** $XXX/month
- **Scope:** System setup, maintenance, support
- **Owner Effort:** Low (you handle inquiries, they handle system)
- **Payment Triggers:** Setup on delivery, retainer monthly
- **Tracking:** Monthly invoice
- **Pros:** Predictable income, ongoing relationship
- **Cons:** May be high for small business
- **Admin Simplicity:** 4/5
- **Anti-Theft Strength:** Medium (they own system after setup)

#### Model 2: Low Setup + Per-Event Fee
- **Setup Fee:** $XXX (one-time, covers deployment)
- **Per-Event Fee:** $XX per booked event (deposit-cleared)
- **Scope:** Setup + ongoing per-event processing
- **Owner Effort:** Medium (you track bookings, they pay per event)
- **Payment Triggers:** Setup on delivery, per-event when deposit cleared
- **Tracking:** Event log, monthly invoice
- **Pros:** Low barrier to entry, pay-as-you-go
- **Cons:** Requires tracking, variable income
- **Admin Simplicity:** 3/5 (requires booking tracking)
- **Anti-Theft Strength:** High (ongoing relationship)

#### Model 3: Commission %
- **Setup Fee:** $XXX (one-time)
- **Commission:** X% of event revenue (or deposit amount)
- **Scope:** Setup + ongoing commission on bookings
- **Owner Effort:** Medium (track revenue, calculate commission)
- **Payment Triggers:** Setup on delivery, commission monthly/quarterly
- **Tracking:** Revenue tracking, commission calculation
- **Pros:** Aligned incentives, scales with success
- **Cons:** Requires revenue transparency, complex tracking
- **Admin Simplicity:** 2/5 (requires revenue tracking)
- **Anti-Theft Strength:** High (ongoing relationship)

#### Model 4: Part-Time Title + Bonus
- **Title:** Events & Growth Coordinator (part-time)
- **Base:** $XXX/month (part-time salary)
- **Bonus:** $XX per booked event or % of revenue
- **Scope:** System management + event coordination
- **Owner Effort:** Low (you handle inquiries, they handle coordination)
- **Payment Triggers:** Monthly salary + bonus quarterly
- **Tracking:** Employment records, bonus calculation
- **Pros:** Formal relationship, clear role
- **Cons:** Employment obligations, tax implications
- **Admin Simplicity:** 3/5 (employment paperwork)
- **Anti-Theft Strength:** Very High (employment relationship)

### Recommended Model: Per-Person Event Fee (Based on Actual Menu Analysis)

**CALCULATED FROM ACTUAL MENU PRICES:**
- Package A (Apps + Drinks): $19/person revenue → $1.00-1.50/person fee (5-8%)
- Package B (Buffet): $27.50/person revenue → $1.50-2.20/person fee (5-8%)
- Package C (Premium): $42.50/person revenue → $2.13-3.40/person fee (5-8%)

**RECOMMENDED PRICING:**
- **Setup Fee:** $1,800 (one-time)
- **Per-Person Fee:** $2.00 per person per booked event (flat rate, all packages)
- **Monthly Retainer:** $250/month (first 6 months, then optional)

**Why $2.00/person:**
- Simple to calculate (guests × $2.00)
- Fair across all package types
- Owner keeps 92-95% of revenue
- Based on actual menu pricing analysis
- Scales with event size

**Examples (Based on Real Menu):**
- 15-person event: $30 fee
- 20-person Package B: $40 fee (owner revenue: $550, net profit: $27.50-33)
- 30-person event: $60 fee
- 50-person event: $100 fee

**Annual Projection (Conservative - 1 event/month, avg 20 people):**
- Setup: $1,800
- Events (12 × $40): $480
- Retainer (6 months × $250): $1,500
- **Total Year 1:** $3,780
- **Year 2+:** $480/year (events only, no retainer)

**Owner ROI Analysis:**
- 20-person Package B event: $550 revenue
- Owner net profit (5-6%): $27.50-33
- System fee: $40
- **Value:** System brings in events they wouldn't have had otherwise
- **Break-even:** If system brings 1-2 additional events/month, owner profits

**Negotiation Band:**
- **High:** $2,000 setup + $2.50/person + $300/month
- **Target:** $1,800 setup + $2.00/person + $250/month
- **Floor:** $1,500 setup + $1.50/person + $200/month

**Walk-Away Floor:**
- Minimum: $1,500 setup + $1.50/person + $200/month
- Below this: Not worth the ongoing maintenance

**See:** REAL_MENU_PRICING_ANALYSIS.md for complete calculations

---

## CUSTOMER EXPERIENCE & FUNCTIONAL DYNAMICS

### Customer Journey (QR Code → Event)
1. **Discovery:** Customer sees QR code (table tent, flyer, Facebook)
2. **Scan:** Phone opens landing page
3. **Browse:** Sees hours, menu, events
4. **Interest:** Clicks "Book an Event"
5. **Form Fill:** Enters event details (2-3 minutes)
6. **Submit:** Form validates, submits
7. **Confirmation:** Sees thank-you page with reference ID
8. **Wait:** Owner calls within 24 hours (as stated)
9. **Confirm:** Owner confirms details, discusses package
10. **Deposit:** Customer pays deposit (if 13+ guests)
11. **Booked:** Event marked as booked
12. **Event:** Kitchen has event sheet, executes smoothly

### Functional Dynamics

#### Form Submission Flow:
```
Customer fills form
  → Client-side validation (instant feedback)
  → API submission (/api/inquiry)
  → Server-side validation (security)
  → Inquiry logged (CHEEKS_INQUIRY)
  → Email sent (if configured)
  → Thank-you page (with ID)
```

#### Booking Flow:
```
Owner receives inquiry
  → Calls customer
  → Confirms details
  → Collects deposit
  → Uses admin page (/admin.html)
  → Marks as BOOKED
  → Event sheet generated
  → Email sent to owners (for kitchen)
```

#### Source Tracking:
- QR code: `?src=qr` or `?src=table-tent`
- Facebook: `?utm_source=facebook`
- Direct: `src=direct` (default)
- All tracked in inquiry payload

### Log Patterns (For Monitoring)
- `CHEEKS_INQUIRY {...}` - New inquiry (always logged)
- `CHEEKS_BOOKED {...}` - Event marked booked
- `CHEEKS_HONEYPOT {...}` - Bot detected (silent)
- `CHEEKS_API_ERROR {...}` - API error
- `CHEEKS_EMAIL_ERR {...}` - Email error

---

## SYSTEM USE PLAN

### Phase 1: Deployment (Days 1-3)
1. Deploy to Vercel
2. Set environment variables
3. Test all endpoints
4. Verify email setup (if using)
5. Test admin interface

### Phase 2: QR Code Creation (Day 4)
1. Generate QR codes (multiple sources)
2. Test QR codes
3. Print table tents
4. Create flyers

### Phase 3: Marketing Launch (Days 5-7)
1. Post on Facebook
2. Place table tents
3. Share QR codes
4. Monitor first inquiries

### Phase 4: Optimization (Ongoing)
1. Track source attribution
2. Monitor inquiry quality
3. Adjust form if needed
4. Add gallery images (optional)

### Responsibilities Matrix

**Cody (You):**
- System deployment
- Environment setup
- Initial testing
- QR code generation
- Training owners
- Ongoing support

**Ryan & Angela:**
- Receive inquiries
- Call customers
- Collect deposits
- Mark events as booked
- Use event sheets
- Provide feedback

---

## KPI DASHBOARD DEFINITIONS

### Key Metrics to Track:

1. **Total Inquiries**
   - Definition: Number of form submissions
   - Source: Vercel logs (CHEEKS_INQUIRY)
   - Frequency: Daily/weekly

2. **Inquiry-to-Booking Rate**
   - Definition: (Booked Events / Total Inquiries) × 100
   - Target: 40-60%
   - Source: Manual calculation (inquiries vs bookings)

3. **Average Party Size**
   - Definition: Average guests per booked event
   - Source: Event sheets
   - Target: 15-25 guests

4. **Revenue Estimate**
   - Definition: (Booked Events × Avg Party Size × Avg Spend per Person)
   - Source: Manual calculation
   - Note: Requires avg spend data

5. **Source Attribution**
   - Definition: Where inquiries come from
   - Source: Inquiry payload (src field)
   - Use: Marketing optimization

6. **Time Saved**
   - Definition: Time saved vs manual booking process
   - Estimate: 15-30 minutes per inquiry
   - Source: Owner feedback

7. **Show Rate**
   - Definition: (Events That Happened / Events Booked) × 100
   - Target: 85-95%
   - Source: Manual tracking

8. **Deposit Collection Rate**
   - Definition: (Deposits Collected / Events Requiring Deposit) × 100
   - Target: 90%+
   - Source: Manual tracking

---

## PRESENTATION SCRIPT ELEMENTS

### 60-Second Pitch:
"Ryan and Angela, I've built a complete event inquiry system for Cheeks. Customers scan a QR code, fill out a form on their phone, and you get all their details instantly. When you collect a deposit, you mark it as booked and the kitchen automatically gets an organized event sheet. It reduces BOH chaos, protects against cancellations, and makes you look professional. I can have it live in a week. Want to see it?"

### Objection Handling:

**"We don't have time to learn a new system"**
- Response: "It takes 5 minutes to learn. I'll train you. The admin page is simple - just fill in event details and click 'Mark Booked.'"

**"What if it doesn't work?"**
- Response: "It's already built and tested. I'll deploy it, test it with you, and support it. If something breaks, I fix it immediately."

**"How much does it cost?"**
- Response: "Let's talk about value. This system will save you 15-30 minutes per inquiry, reduce no-shows with deposits, and bring in more events. I'm proposing [MODEL] which is [AMOUNT]. That's less than one good event pays for."

**"Can we just use Facebook/phone?"**
- Response: "You can, but this is more professional, organized, and tracks everything. Plus, you get event sheets automatically for the kitchen. It's the difference between sticky notes and a real system."

**"What if we don't like it?"**
- Response: "The system is yours. If you don't want to continue, you keep what's built. No ongoing costs if you don't want support."

---

## STAGED DISCLOSURE PROTOCOL

### Pre-Deal (Presentation):
- Show landing page
- Show form
- Show admin interface (demo)
- Explain flow
- Show sample event sheet
- Discuss pricing model
- **DO NOT SHOW:** Code, technical details, backend structure

### Post-Deal (Implementation):
- Full system access
- Code repository (if requested)
- Technical documentation
- Training materials
- Support access

### Access Control:
- **Public:** Landing page, form
- **Protected:** Admin page (ADMIN_TOKEN)
- **Private:** Code, API structure, logs

---

## IMPLEMENTATION PLAN (7-14 Days)

### Week 1:
- **Day 1:** Deploy to Vercel, set environment variables
- **Day 2:** Test all functionality, verify emails
- **Day 3:** Create QR codes, test QR flow
- **Day 4:** Train owners on admin interface
- **Day 5:** Print table tents, create marketing materials
- **Day 6:** Soft launch (test with friends/family)
- **Day 7:** Monitor, adjust, optimize

### Week 2:
- **Day 8-10:** Full launch, marketing push
- **Day 11-12:** Monitor inquiries, provide support
- **Day 13-14:** Review metrics, optimize, plan next steps

---

## FINAL CHECKLIST FOR PRESENTATION MEETING

### Materials to Bring:
- [ ] Laptop with demo site loaded
- [ ] Mobile phone (for QR code demo)
- [ ] Printed sample event sheet
- [ ] Pricing proposal (printed)
- [ ] Implementation timeline
- [ ] Backup: USB with all materials

### Demo Flow:
1. Show landing page on mobile (QR code scan simulation)
2. Fill out form (test data)
3. Show thank-you page
4. Show admin interface (demo mode)
5. Show event sheet preview
6. Show sample email notification
7. Discuss pricing
8. Answer questions
9. Close: "Ready to get started?"

### Talking Points:
- Problem: BOH chaos, manual booking, no organization
- Solution: Automated inquiry system, event sheets, source tracking
- Value: Time saved, reduced cancellations, professional image
- Ask: Choose pricing model, set deployment date
- Next Steps: Sign agreement, deploy, train, launch

---

## REAL PRICING CALCULATIONS (Based on Actual Menu)

### Menu Analysis (From index.html):
- **Appetizers:** $5.99-$9.99 (avg $8.50)
- **Sandwiches:** $11.99-$16.99 (avg $13.19)
- **Salads/Wraps:** $12.99
- **Kids:** $5.99-$8.99 (avg $6.99)
- **Dessert:** $6.99

### Event Package Revenue (Calculated):
- **Package A (Apps + Drinks):** $19/person
- **Package B (Buffet):** $27.50/person
- **Package C (Premium):** $42.50/person

### Profit Margin Analysis:
- **Food Cost:** 30% of revenue (industry standard)
- **Labor:** 30% of revenue
- **Overhead:** 20% of revenue
- **Net Profit:** 4-6% (bar & grill typical)

### Per-Person Fee Calculation:
- **$2.00/person** = 5-8% of event revenue (fair across all packages)
- Owner keeps 92-95% of revenue
- Simple to calculate and track

**Complete Analysis:** See REAL_MENU_PRICING_ANALYSIS.md

---

## RESEARCH NOTES

### Labor Benchmarks (WI/Wausau-Adjusted):

**Event Coordinator:**
- National Average: $18-25/hour
- Wisconsin Adjusted: $16-22/hour (lower cost of living)
- Wausau Adjusted: $15-20/hour (smaller market)
- **Recommended Range:** $15-20/hour or $2,400-3,200/month (part-time)
- **Sources:** 
  - Bureau of Labor Statistics (BLS) - Event Coordinator wages
  - ZipRecruiter - Wausau, WI event coordinator salaries
  - Glassdoor - Wisconsin event coordinator salaries

**Event Sales:**
- National Average: $40,000-60,000/year + commission
- Wisconsin Adjusted: $35,000-50,000/year + commission
- Commission: 5-15% of event revenue
- **Recommended:** $35,000-45,000/year + 8-12% commission
- **Sources:**
  - PayScale - Event Sales Representative salaries
  - Indeed - Restaurant event sales salaries

**Marketing Operations:**
- National Average: $50,000-70,000/year
- Wisconsin Adjusted: $45,000-60,000/year
- **Recommended:** $45,000-55,000/year
- **Sources:**
  - BLS - Marketing Manager wages
  - Salary.com - Marketing Operations Manager

### Web Build Pricing:

**Landing Page Development:**
- Simple Landing Page: $500-1,500
- Custom Landing Page: $1,500-5,000
- Landing Page + Form: $2,000-6,000
- **This Project:** Custom landing + form + API + admin = $2,500-4,000 value
- **Sources:**
  - Upwork - Landing page development rates
  - Fiverr - Professional landing page pricing
  - Clutch - Web development agency pricing

**Funnel Optimization:**
- Conversion optimization: $500-2,000
- A/B testing setup: $300-1,000
- **This Project:** Built-in optimization = $500-1,000 value

**Tracking Setup:**
- Analytics setup: $200-500
- Source tracking: $300-800
- **This Project:** Built-in tracking = $300-500 value

**Maintenance Pricing:**
- Monthly maintenance: $100-300/month
- Updates/improvements: $50-150/hour
- **Recommended:** $200-400/month retainer

### Commission Norms:

**Event Sales Commission:**
- Industry Standard: 5-15% of event revenue
- Restaurant Events: 8-12% typical
- Catering: 10-15% typical
- **Recommended:** 8-10% of event revenue OR $25-50 per booked event
- **Sources:**
  - Restaurant Business Online - Event sales commission structures
  - Catering industry standards
  - Event industry benchmarks

**Per-Event Fee Alternative:**
- $25-50 per booked event (deposit-cleared)
- Simpler than percentage
- Predictable for owners
- **Recommended:** $35 per booked event

### Deposit Policy Best Practices:

**Industry Standards:**
- Groups 10-15+: Require deposit
- Deposit Amount: 20-50% of estimated total
- Minimum: $100-200 for small events
- **Recommended for Cheeks:** 
  - 13+ guests: $200 deposit
  - Protects against cancellations
  - Reduces BOH stress
- **Sources:**
  - Restaurant event booking best practices
  - Small business deposit policies
  - Cancellation protection strategies

**Small Kitchen Protection:**
- Pre-booking reduces last-minute chaos
- Deposit ensures commitment
- Event sheets enable better prep
- **Value:** Reduces stress, improves execution

### Domain Strategy:

**Canonical Domain:**
- Primary: `cheeks-bar-and-grill.vercel.app` (current)
- Custom: `events.cheeksbar.com` or `book.cheeksbar.com` (recommended)
- **Best Practice:** Use custom domain for professionalism

**Redirects:**
- All variations redirect to canonical
- www and non-www handled
- HTTP to HTTPS redirect

**Listing Consistency:**
- Google Business Profile: Use canonical URL
- Facebook: Use canonical URL
- Yelp: Use canonical URL
- **Important:** Consistent URL across all platforms

---

**Last Updated:** December 28, 2025  
**Next Steps:** Complete research, finalize pricing, prepare presentation materials

