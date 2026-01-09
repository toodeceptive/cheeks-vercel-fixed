# CHEEKS — OPERATIONS + COMMS LOG (FINAL v1.0)

**Scope**: Apple Maps listing/pin corrections + Owner/Angela website pricing exchange  
**Method**: Evidence-based (screenshots + video referenced) + verbatim message capture  
**Status**: FINAL / AUDIT-READY

---

## A) APPLE MAPS: LISTING & PIN CORRECTION LOG (IMAGES + VIDEO)

### AM-F1 — Prior listing ("Nancys Jamars") confirmed closed + Apple applied update

**Evidence** (Screenshot: Reviewed Reports):
- Listing shown: "Nancys Jamars"
- Status shown: "It's closed"
- Date shown: "Dec 29"
- Apple confirmation text shown:
  "We've updated Maps based on the issue you reported. Thanks for helping to improve Apple Maps."

**Interpretation**:
- Apple reviewed the report and applied a change (closure/identity layer cleanup).

**Current state**:
- CONFIRMED APPLIED (closure update)

**SSOT Reference**: `LISTINGS.apple_maps.old_listing_closure`

---

### AM-F2 — Apple push notification received confirming the update

**Evidence** (Lock Screen screenshot(s)):
- Date shown: "Tue Jan 6"
- Notification text shown:
  "Nancys Jamars — We've updated Maps based on the issue you reported."
- Timing indicator shown: "2m ago" (relative at capture time)

**Interpretation**:
- Apple issued a user-facing confirmation after processing the report.

**Current state**:
- CONFIRMED NOTIFICATION RECEIVED

**SSOT Reference**: `LISTINGS.apple_maps.notification_confirmation`

---

### AM-F3 — New report submitted to correct Cheeks pin/location

**Evidence** (Screenshots: Report an Issue flow):
- Screen question shown:
  "What issue do you want to report about Cheeks Bar and Grill?"
- Selected option shown (checked):
  "Address or location on map is wrong"
- Instruction shown:
  "Move the map to the correct location."
- Address block shown (as displayed in the report UI):
  "158241 E Wausau Ave, Wausau, WI 54403, United States"
- Your written explanation shown (verbatim):
  "It should be where 'Nancys Jamars' was, which is now closed, permanently, and replaced by Cheek's Bar and Grill."

**Video** (referenced):
- Corroborates deliberate reporting flow + map movement/pin adjustment (used as corroboration only).

**Interpretation**:
- The identity layer (old business closed) was handled first, then the geospatial layer (pin accuracy).
- Correct issue type selected for a pin correction.

**Current state**:
- SUBMITTED / PENDING REVIEW (no acceptance confirmation shown in evidence set)

**SSOT Reference**: `LISTINGS.apple_maps.pin_correction_status`

**Note**: Address shown in report UI ("158241 E Wausau Ave") conflicts with website address ("4011 E Wausau Ave"). This discrepancy requires resolution.

---

### AM-QC — Accuracy/clarity checks

- No invented timelines or internal Apple processing assumptions.
- No claims about exact pin coordinates beyond "move the map to the correct location" instruction + corroboration.
- Duplicate lock screen screenshot(s) likely represent the same notification; retained as redundant evidence.

---

### AM-NEXT — Optimal actions (low-risk)

1. Do not submit additional duplicate pin reports yet (avoid conflicting review threads).
2. Re-check Apple Maps periodically for a silent pin move or a new confirmation.
3. Once pin is correct, standardize the canonical map link across:
   - Website "Directions"
   - QR destinations (and any UTM/source variants)
   - Facebook, Yelp, other listings

**SSOT Reference**: `LISTINGS.apple_maps.next_actions`

---

## B) OWNER COMMS: WEBSITE PRICING MESSAGE LOG (VERBATIM)

### MSG-001 (Inbound — Angela)

**Date**: [Not specified in log]  
**Source**: Text message  
**Content**:
```
Hey Cody this is Angela from cheeks. Do you have an estimate on cost for a website? Thanks!
```

**SSOT Reference**: `BUSINESS_DOCS.pricing_comms.msg_001`

---

### MSG-002 (Outbound — Cody)

**Date**: [Not specified in log]  
**Source**: Text message  
**Content**:
```
Hey Angela. Great to hear from you!
```

**SSOT Reference**: `BUSINESS_DOCS.pricing_comms.msg_002`

---

### MSG-003 (Outbound — Cody)

**Date**: [Not specified in log]  
**Source**: Text message  
**Content**:
```
Hey Angela — great to hear from you.

Yep, I can give you a solid estimate. Quick question first so we don't duplicate work: do you and Ryan still have access to cheeksbar.com, and are you still working with the person who set that up? If you have access, I can connect everything to that domain. If not, I'll recommend the cleanest option so you fully control it going forward.

Also — I already have a clean, mobile-friendly Cheeks landing page built and ready to show. Want me to send you the preview link?

Pricing options (fair + flexible):

Option A (monthly / simplest)
• $149/mo — landing page + hosting/maintenance + SEO basics + up to 30 min of small updates per month
• $249/mo — includes monthly content updates (events/photos/menu) + basic traffic/reporting

Option B (one-time build + smaller monthly)
• $500 build + $79/mo (hosting/maintenance + up to 30 min updates per month)
• $900 build + $129/mo (adds monthly content updates + reporting)

Domain registration is separate at cost (usually ~$12–$20/yr depending on where it's registered).

If you tell me whether you want just a simple landing page or a full multi-page website, I'll confirm the best option and we can lock it in. And if you ever want to expand into bigger marketing/advertising later, I'll credit part of your first month toward that upgrade so it's not double-paid.
```

**SSOT Reference**: `BUSINESS_DOCS.pricing_comms.msg_003`, `DEPLOYMENT.domain_status` (BLOCKED)

**Key Points**:
- Domain access question: `cheeksbar.com` access status unknown
- Preview link available
- Pricing options detailed (Option A: $149/$249/mo, Option B: $500-900 build + $79-129/mo)
- Domain registration separate (~$12-20/yr)

---

### MSG-004 (Outbound — Cody)

**Date**: [Not specified in log]  
**Source**: Text message  
**Content**:
```
Sorry, was driving and losing signal. Just to clarify:

▸ Website pricing (as shared)
  • Monthly option: $149/mo (or $249/mo with content updates)
  • One-time build option: $500–$900 + smaller monthly
  • Domain registration is separate at cost (~$12–$20/year)

▸ Domain check (to avoid duplicate work)
  • Do you and Ryan have access to cheeksbar.com, or are you still working with the person who set that up?
  • If you have access, I can connect and use that domain.
  • If not, I'll recommend the cleanest option so you fully control it.

▸ Optional next step
  • I already have a clean, mobile-friendly landing page built and ready to show.
  • Happy to send a quick preview link if you'd like to see it before deciding.

No rush at all, just wanted to make sure everything was clear.
```

**SSOT Reference**: `BUSINESS_DOCS.pricing_comms.msg_004`

**Key Points**:
- Clarification of pricing structure
- Domain access question reiterated
- Preview link offer reiterated

---

### MSG-STATUS (Current)

**Status**: Awaiting response from Angela

**Open items**:
1. Domain access confirmation (`cheeksbar.com`)
2. Preview link request
3. Website scope selection (simple landing page vs full multi-page)

**SSOT Reference**: `BUSINESS_DOCS.pricing_comms.status`, `DEPLOYMENT.domain_status` (BLOCKED)

---

## CROSS-REFERENCES TO SSOT

### Address Conflict
- **Website**: "4011 E Wausau Ave" (from `index.html`, `schema.json`)
- **Operations Log**: "158241 E Wausau Ave" (from Apple Maps report UI)
- **Action Required**: Verify correct address, resolve conflict

### Domain Status
- **Question**: Do Angela and Ryan have access to `cheeksbar.com`?
- **Current**: BLOCKED - awaiting response
- **Impact**: Cannot finalize domain strategy until resolved

### Listings Status
- **Apple Maps**: Pin correction submitted, pending review
- **Old Listing**: "Nancys Jamars" confirmed closed
- **Action**: Monitor for pin correction confirmation

### Pricing Documentation
- **Options**: Documented in MSG-003 and MSG-004
- **Status**: Awaiting Angela's selection
- **Website**: Current site does not display pricing (event inquiry system only)

---

**END FINAL LOG v1.0**
