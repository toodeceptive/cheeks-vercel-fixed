# Live System Test — Step-by-Step Testing Plan
**Date:** December 28, 2025  
**Test Type:** Comprehensive Live System Testing  
**Base URL:** `https://cheeks-bar-and-grill.vercel.app/`

---

## TEST EXECUTION PLAN

### Phase 1: Basic Site Load & Navigation
### Phase 2: Form Submission Flow
### Phase 3: Admin Interface
### Phase 4: Mobile Responsiveness
### Phase 5: Link Verification
### Phase 6: API Endpoint Testing
### Phase 7: Source Tracking
### Phase 8: Error Handling

---

## PHASE 1: BASIC SITE LOAD & NAVIGATION

### Test 1.1: Homepage Load
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/`
- [ ] Verify page loads without errors
- [ ] Check browser console for errors
- [ ] Verify all CSS loads
- [ ] Verify all JavaScript loads
- [ ] Check page title: "Cheeks Bar & Grill | Wausau, Wisconsin"
- [ ] Verify hero image loads (or graceful degradation)

**Expected:** Page loads completely, no console errors

### Test 1.2: Navigation Links
- [ ] Click "Hours" link → Should scroll to #hours section
- [ ] Click "Menu" link → Should scroll to #menu section
- [ ] Click "Events" link → Should scroll to #events section
- [ ] Click "Gallery" link → Should scroll to #gallery section
- [ ] Click "Book an Event" link → Should scroll to #book section
- [ ] Click phone number → Should open phone dialer
- [ ] Click "Call Now" button → Should open phone dialer

**Expected:** All navigation works smoothly

### Test 1.3: External Links
- [ ] Click "Get Directions" → Should open Google Maps
- [ ] Click "Apple Maps" (if visible) → Should open Apple Maps
- [ ] Click Facebook link → Should open Facebook page
- [ ] Click Yelp link → Should open Yelp page
- [ ] Click email link → Should open email client

**Expected:** All external links work correctly

---

## PHASE 2: FORM SUBMISSION FLOW

### Test 2.1: Form Display
- [ ] Navigate to #book section
- [ ] Verify form is visible
- [ ] Verify all form fields present:
  - [ ] Name
  - [ ] Phone
  - [ ] Email
  - [ ] Event Type
  - [ ] Date
  - [ ] Time
  - [ ] Guests
  - [ ] Package
  - [ ] Notes
- [ ] Verify honeypot field is hidden

**Expected:** Form displays correctly with all fields

### Test 2.2: Client-Side Validation
- [ ] Try to submit empty form → Should show validation errors
- [ ] Enter invalid email → Should show error
- [ ] Enter past date → Should show error
- [ ] Enter invalid guest count (0 or >200) → Should show error
- [ ] Enter valid data → Should allow submission

**Expected:** Client validation works correctly

### Test 2.3: Form Submission
- [ ] Fill form with test data:
  - Name: "Test User"
  - Phone: "715-555-1234"
  - Email: "test@example.com"
  - Event Type: "Birthday"
  - Date: Future date (7 days from now)
  - Time: "18:00"
  - Guests: "20"
  - Package: "B"
  - Notes: "Test submission"
- [ ] Submit form
- [ ] Verify loading state
- [ ] Verify redirect to `/thank-you.html?id=...`
- [ ] Verify reference ID displays

**Expected:** Form submits successfully, redirects to thank-you page

### Test 2.4: Server Response Verification
- [ ] Check browser Network tab for `/api/inquiry` request
- [ ] Verify request method: POST
- [ ] Verify request payload includes all fields
- [ ] Verify response: `{ok: true, id: "..."}`
- [ ] Verify status code: 200

**Expected:** API responds correctly

---

## PHASE 3: ADMIN INTERFACE

### Test 3.1: Admin Page Access
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/admin.html`
- [ ] Verify page loads
- [ ] Verify form is visible
- [ ] Verify token field is present
- [ ] Check robots meta: `noindex,nofollow`

**Expected:** Admin page loads correctly

### Test 3.2: Admin Form Submission (Preview)
- [ ] Enter ADMIN_TOKEN (if available)
- [ ] Fill form with test data
- [ ] Click "Preview Event Sheet"
- [ ] Verify preview displays
- [ ] Verify event sheet HTML is correct

**Expected:** Preview works correctly

### Test 3.3: Admin Form Submission (Book)
- [ ] Enter ADMIN_TOKEN
- [ ] Fill form with test data
- [ ] Enter valid guest count (1-200)
- [ ] Click "Mark as BOOKED"
- [ ] Verify success message
- [ ] Verify event sheet generated

**Expected:** Booking works correctly

### Test 3.4: Admin Error Handling
- [ ] Try without token → Should show error
- [ ] Try with invalid token → Should show 401 error
- [ ] Try with invalid guest count → Should show 400 error

**Expected:** Error handling works correctly

---

## PHASE 4: MOBILE RESPONSIVENESS

### Test 4.1: Mobile Viewport (375px)
- [ ] Resize browser to 375px width
- [ ] Verify hamburger menu appears
- [ ] Verify navigation collapses
- [ ] Verify form fields stack correctly
- [ ] Verify buttons are touch-friendly (44x44px minimum)
- [ ] Verify text is readable (16px+)
- [ ] Verify no horizontal scrolling

**Expected:** Mobile layout works correctly

### Test 4.2: Tablet Viewport (768px)
- [ ] Resize browser to 768px width
- [ ] Verify layout adapts
- [ ] Verify navigation works
- [ ] Verify form layout is appropriate

**Expected:** Tablet layout works correctly

### Test 4.3: Touch Interactions
- [ ] Test hamburger menu toggle
- [ ] Test form field focus
- [ ] Test button taps
- [ ] Test link taps
- [ ] Verify no double-tap zoom issues

**Expected:** Touch interactions work smoothly

---

## PHASE 5: LINK VERIFICATION

### Test 5.1: Internal Anchor Links
- [ ] Test all #anchor links
- [ ] Verify smooth scrolling
- [ ] Verify correct section loads
- [ ] Test skip link (#main)

**Expected:** All anchor links work

### Test 5.2: External Links
- [ ] Test tel: link → Phone dialer
- [ ] Test mailto: link → Email client
- [ ] Test Google Maps → Maps app
- [ ] Test Apple Maps → Maps app
- [ ] Test Facebook → Facebook page
- [ ] Test Yelp → Yelp page

**Expected:** All external links work

### Test 5.3: Asset Links
- [ ] Verify CSS loads: `/styles.css`
- [ ] Verify JS loads: `/app.js`
- [ ] Verify images load (or graceful degradation)
- [ ] Verify favicon loads

**Expected:** All assets load correctly

---

## PHASE 6: API ENDPOINT TESTING

### Test 6.1: Health Check
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/api/health`
- [ ] Verify response: `{ok: true, service: "cheeks-event-funnel", ...}`
- [ ] Verify status code: 200

**Expected:** Health endpoint works

### Test 6.2: Sample Inquiry
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/api/sample-inquiry`
- [ ] Verify response: `{ok: true, sample: {...}}`
- [ ] Verify sample data is valid
- [ ] Verify status code: 200

**Expected:** Sample endpoint works

### Test 6.3: Inquiry Submission (API Direct)
- [ ] POST to `/api/inquiry` with test data
- [ ] Verify response: `{ok: true, id: "..."}`
- [ ] Verify status code: 200
- [ ] Verify error handling (invalid data)

**Expected:** API endpoint works correctly

---

## PHASE 7: SOURCE TRACKING

### Test 7.1: Base URL (No Source)
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/`
- [ ] Submit form
- [ ] Check Network tab for request payload
- [ ] Verify `src: "direct"` in payload

**Expected:** Default source tracking works

### Test 7.2: Source Parameter
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent`
- [ ] Submit form
- [ ] Verify `src: "qr-table-tent"` in payload

**Expected:** Source parameter tracking works

### Test 7.3: UTM Parameters
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/?utm_source=facebook`
- [ ] Submit form
- [ ] Verify `src: "facebook"` in payload

**Expected:** UTM parameter tracking works

---

## PHASE 8: ERROR HANDLING

### Test 8.1: 404 Page
- [ ] Navigate to: `https://cheeks-bar-and-grill.vercel.app/nonexistent`
- [ ] Verify 404.html displays
- [ ] Verify styled error page
- [ ] Verify link back to home

**Expected:** 404 page works correctly

### Test 8.2: Form Error Handling
- [ ] Test invalid form submissions
- [ ] Verify error messages display
- [ ] Verify form doesn't submit with errors
- [ ] Verify network errors handled gracefully

**Expected:** Error handling works correctly

### Test 8.3: API Error Handling
- [ ] Test invalid API requests
- [ ] Verify appropriate error responses
- [ ] Verify error messages are clear

**Expected:** API error handling works correctly

---

## TEST RESULTS SUMMARY

### Tests Completed: ___ / 50+
### Tests Passed: ___ / 50+
### Tests Failed: ___ / 50+
### Issues Found: ___

### Critical Issues: ___
### Minor Issues: ___
### Recommendations: ___

---

**Test Started:** [TIMESTAMP]  
**Test Completed:** [TIMESTAMP]  
**Tester:** [NAME]  
**Environment:** Production (Vercel)

