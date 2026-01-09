# Google Business Profile Setup Instructions

## Status
**Current**: Google Business Profile URL not yet added to schema  
**Action Required**: Obtain Google Business Profile URL from business owners

## Why This Matters
Adding the Google Business Profile URL to the `sameAs` array improves:
- Local SEO visibility
- Listing consistency across platforms
- Search engine understanding of business relationships

## How to Find the Google Business Profile URL

### Option 1: Ask Business Owners
1. Ask Angela or Ryan if they have access to their Google Business Profile
2. They can find it by:
   - Going to https://business.google.com
   - Or searching for their business on Google Maps
   - The profile URL format is: `https://www.google.com/maps/place/[business-name]/@[coordinates]/`

### Option 2: Search Google Maps
1. Search for "Cheeks Bar and Grill Wausau WI" on Google Maps
2. Click on the business listing
3. Copy the URL from the address bar
4. Format should be: `https://www.google.com/maps/place/...`

## Once You Have the URL

### Update Files:
1. **schema.json** - Add to `sameAs` array:
   ```json
   "sameAs": [
     "https://www.yelp.com/biz/cheeks-bar-and-grill-wausau",
     "https://www.facebook.com/profile.php?id=61571389349445",
     "https://www.google.com/maps/place/[YOUR-GOOGLE-BUSINESS-URL]"
   ]
   ```

2. **index.html** - Add to JSON-LD `sameAs` array (around line 55-58):
   ```json
   "sameAs": [
     "https://www.yelp.com/biz/cheeks-bar-and-grill-wausau",
     "https://www.facebook.com/profile.php?id=61571389349445",
     "https://www.google.com/maps/place/[YOUR-GOOGLE-BUSINESS-URL]"
   ]
   ```

## Verification
After adding:
1. Test on live site: https://cheeks-bar-and-grill.vercel.app
2. Check that `schema.json` includes the new URL
3. Verify JSON-LD in page source includes the URL

## Related Patches
- **PATCH-005**: Add Google Business Profile URL (HIGH priority)
- **AUDIT_FINDINGS.md**: FINDING-HIGH-003

## Notes
- Google Maps links are already present in the HTML
- This adds the explicit Business Profile URL for better SEO
- If business doesn't have a Google Business Profile, they should create one
