# ARTIFACT CLASSIFICATION

**Wave**: 2 - Classification & Conflicts  
**Status**: COMPLETE  
**Date**: 2025-01-XX

---

## CLASSIFICATION SCHEME

- **PRIMARY**: Authoritative source (canonical truth)
- **SECONDARY**: Supporting documentation
- **DERIVED**: Generated from primary sources
- **STALE**: Outdated, superseded
- **BLOCKED**: Inaccessible, requires user action

---

## PRIMARY SOURCES

### Code Files
- `index.html` - Main landing page, business data source
- `schema.json` - Structured data (JSON-LD), business data source
- `vercel.json` - Deployment configuration (canonical)

### Business Data Sources
- `index.html:31-59` - JSON-LD structured data (name, address, phone, email, hours)
- `index.html:41` - Address in structured data: "4011 E Wausau Ave"
- `schema.json:41` - Address in schema: "4011 E Wausau Ave"
- `index.html:200-222` - Hours (display)
- `index.html:228-459` - Menu (hardcoded)

### Configuration
- `vercel.json` - Deployment config (canonical)
- `package.json` - Project metadata (canonical)
- `robots.txt` - SEO config (canonical)
- `sitemap.xml` - Sitemap (canonical)

---

## SECONDARY SOURCES

### Supporting Pages
- `thank-you.html` - Confirmation page
- `admin.html` - Admin interface
- `404.html` - Error page

### Client-Side Code
- `app.js` - Client-side JavaScript
- `admin.js` - Admin JavaScript

### API Endpoints
- `api/inquiry.js` - Form submission handler
- `api/mark-booked.js` - Booking handler
- `api/health.js` - Health check
- `api/sample-inquiry.js` - Demo generator

### Styles
- `styles.css` - All styling

### Documentation
- `README.md` - System documentation
- `docs/` - All documentation files
- `pp_cheeks/OPERATIONS_LOG.md` - Operations/comms log

---

## DERIVED SOURCES

### Generated Files
- `sitemap.xml` - Generated from site structure (could be auto-generated)
- `site.webmanifest` - PWA manifest (derived from project config)

### Verification Files
- `verify/` - All verification proof files (derived from live checks)

---

## STALE SOURCES

### Outdated Files
- `verify/schema_presence_proof.txt:6` - Shows "158241 E Wausau Ave" (outdated/incorrect)
  - **Reason**: Contains incorrect address, superseded by current code
  - **Current**: "4011 E Wausau Ave" (in code)
  - **Status**: STALE - should be updated or removed

### Archive Files
- Desktop ZIP files (multiple versions) - Historical archives
- **Status**: STALE - superseded by current repo

---

## BLOCKED SOURCES

### Inaccessible Items
1. **Domain Access** (`cheeksbar.com`)
   - **Why Blocked**: Unknown if Angela/Ryan have access
   - **Required Action**: Angela must confirm domain access status
   - **Impact**: Cannot finalize domain strategy
   - **Reference**: `OPERATIONS_LOG.md:MSG-003`, `BLOCKERS.md:BLOCK-001`

2. **Apple Maps Pin Confirmation**
   - **Why Blocked**: Correction submitted, awaiting Apple confirmation
   - **Required Action**: Monitor Apple Maps for pin update
   - **Impact**: Cannot standardize map links until confirmed
   - **Reference**: `OPERATIONS_LOG.md:AM-F3`, `BLOCKERS.md:BLOCK-002`

3. **Listings Verification**
   - **Yelp**: Requires Yelp account access
   - **Facebook**: Requires Facebook account access
   - **Google Business**: Requires Google Business account access
   - **Impact**: Cannot verify listing consistency
   - **Reference**: `agent4.web.md`

4. **Environment Variables (Values)**
   - **Why Blocked**: Security - never print secret values
   - **Status**: Only variable names recorded
   - **Reference**: `agent3.deploy.md`

---

## CONFLICT TABLES

### Address Conflict

| Source | Value | Status | Confidence | Evidence |
|--------|-------|--------|------------|----------|
| `index.html:41` | "4011 E Wausau Ave" | PRIMARY | HIGH | Structured data |
| `schema.json:41` | "4011 E Wausau Ave" | PRIMARY | HIGH | Schema file |
| `index.html:178,186,565,573,582,592` | "4011 E Wausau Ave" | PRIMARY | HIGH | Map links, display |
| Live site | "4011 E Wausau Ave" | PRIMARY | HIGH | Browser verification |
| `OPERATIONS_LOG.md:AM-F3` | "158241 E Wausau Ave" | SECONDARY | LOW | Apple Maps report UI (likely error) |
| `verify/schema_presence_proof.txt:6` | "158241 E Wausau Ave" | STALE | LOW | Outdated verification file |

**Resolution**: "4011 E Wausau Ave" is correct (confirmed by git history, live site, all code sources). "158241" is likely user error in Apple Maps report or outdated test data.

**Action**: Verify with owner if needed, but evidence strongly supports "4011".

---

### Business Name Conflict

| Source | Value | Status | Confidence | Evidence |
|--------|-------|--------|------------|----------|
| `index.html:9` | "Cheeks Bar & Grill" | PRIMARY | HIGH | Title tag |
| `index.html:35` | "Cheeks Bar and Grill" | PRIMARY | HIGH | Structured data |
| `index.html:99,160,592` | "Cheeks Bar and Grill" | PRIMARY | HIGH | Display text |
| `schema.json:35` | "Cheeks Bar and Grill" | PRIMARY | HIGH | Schema |
| `OPERATIONS_LOG.md:AM-F3` | "Cheek's Bar and Grill" | SECONDARY | LOW | User input in Apple Maps report |

**Resolution**: Standardize to "Cheeks Bar and Grill" (no apostrophe, "and" not "&" for body text). Title can use "Cheeks Bar & Grill" for brevity.

**Action**: Minor inconsistency, low priority. Consider standardizing.

---

### Domain Conflict

| Source | Value | Status | Confidence | Evidence |
|--------|-------|--------|------------|----------|
| Current deployment | `cheeks-bar-and-grill.vercel.app` | PRIMARY | HIGH | Live site |
| Operations log | `cheeksbar.com` | BLOCKED | UNKNOWN | Domain access unknown |
| DNS resolution | `cheeksbar.com` → Cloudflare IPs | BLOCKED | UNKNOWN | Points to different service |

**Resolution**: BLOCKED - awaiting Angela's response about domain access.

**Action**: Mark as BLOCKED until domain access confirmed.

---

### Listings Status

| Listing | URL | Status | Verification |
|---------|-----|--------|--------------|
| Yelp | `https://www.yelp.com/biz/cheeks-bar-and-grill-wausau` | REFERENCED | BLOCKED (requires account) |
| Facebook | `https://www.facebook.com/profile.php?id=61571389349445` | REFERENCED | BLOCKED (requires account) |
| Apple Maps | Pin correction submitted | PENDING | BLOCKED (awaiting Apple) |
| Google Business | Not explicitly referenced | MISSING | BLOCKED (requires account) |

**Resolution**: Yelp and Facebook referenced correctly. Apple Maps correction pending. Google Business not explicitly referenced.

**Action**: Add Google Business Profile URL if available.

---

## SUMMARY

### Primary Sources: 8 files
- Core HTML, JSON, config files

### Secondary Sources: 15+ files
- Supporting pages, scripts, documentation

### Derived Sources: 2+ files
- Generated/manifest files

### Stale Sources: 1 file
- Outdated verification file

### Blocked Sources: 5+ items
- Domain access, listings verification, Apple Maps confirmation

### Conflicts: 4 identified
- Address (resolved: "4011" is correct)
- Business name (minor, low priority)
- Domain (blocked)
- Listings (partial blocked)

---

**END CLASSIFICATION REPORT**
