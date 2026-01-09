# QR Code Update Instructions

## Status
**Current**: QR code PDF exists but missing source parameter  
**File Location**: Desktop (or archived in `docs/archive/desktop-files/comprehensive-cleanup/pdfs/`)  
**Action Required**: Update QR code URL to include `?src=qr-table-tent` parameter

## Why This Matters
Adding the source parameter enables:
- Source tracking for QR code scans
- Analytics to see which marketing channels work
- Better understanding of customer acquisition

## Current vs Recommended URL

### Current URL (in PDF):
```
https://cheeks-bar-and-grill.vercel.app/
```

### Recommended URL:
```
https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent
```

## How to Update the QR Code

### Step 1: Open QR Code Generator
Use any QR code generator tool:
- https://www.qr-code-generator.com/
- https://www.qrcode-monkey.com/
- Or any other QR code generator

### Step 2: Generate New QR Code
1. Select "URL" as the QR code type
2. Enter the recommended URL: `https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent`
3. Customize design (optional - match your branding)
4. Generate QR code

### Step 3: Save the QR Code
1. Download as high-resolution PNG or PDF
2. Recommended file name: `qr-table-tent.png` or `qr-table-tent.pdf`
3. Save to: `assets/images/qr-table-tent.png` (for web use)
4. Keep original PDF for printing

### Step 4: Test the QR Code
1. Scan the new QR code with your phone
2. Verify it goes to: `https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent`
3. Fill out the form and submit
4. Check Vercel logs to verify `"src": "qr-table-tent"` appears in inquiry data

## Multiple QR Codes (Optional)
You can create multiple QR codes for different sources:
- `?src=qr-table-tent` - For table tents
- `?src=qr-flyer` - For flyers
- `?src=qr-business-card` - For business cards
- `?src=qr-menu` - For menus

## Verification
After updating:
1. Scan QR code → Should land on site with `?src=qr-table-tent` in URL
2. Submit form → Check logs for `"src": "qr-table-tent"` in inquiry data
3. Verify source tracking works in admin dashboard

## Related Patches
- **PATCH-004**: QR code source parameter (HIGH priority)
- **AUDIT_FINDINGS.md**: FINDING-HIGH-002
- **SSOT.cheeks.yaml**: BRAND_ASSETS.qr_code

## Notes
- QR code is a permanent static link (won't change)
- Source parameter enables tracking without changing the base URL
- System already supports source tracking - just needs the parameter in QR code
