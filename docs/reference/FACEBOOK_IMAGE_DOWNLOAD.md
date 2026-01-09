# Facebook Image Download Instructions

**Facebook Page:** https://www.facebook.com/profile.php?id=61571389349445

## Images to Download

### 1. Logo / Brand Mark
- **Where to find:** Profile picture or cover photo
- **Save as:** `assets/images/logo.png` (then convert to WebP)
- **Usage:** Replace the emoji/placeholder in the header brand section

### 2. Sign Photo
- **Where to find:** Photos section → Look for outdoor sign
- **Save as:** `assets/images/sign.png` (then convert to WebP)
- **Usage:** Hero section background or featured image

### 3. Additional Photos
- **Interior shots:** For gallery or about section
- **Food photos:** For menu section or gallery
- **Staff photos:** Already referenced as `staff.webp`

## Conversion to WebP

After downloading images from Facebook:

1. **Use online converter:** https://cloudconvert.com/png-to-webp
2. **Or use Python script:** Run `convert_images.py` in the project root
3. **Save to:** `assets/images/` directory

## Current Placeholder

The site currently uses:
- Emoji (🍻) as brand mark placeholder
- Generic hero image or fallback

Once you download and convert images, update:
- `index.html` line 85: Replace emoji with `<img src="/assets/images/logo.webp" alt="Cheeks Bar & Grill Logo" />`
- `index.html` line 127: Update hero image source if needed

---

**Note:** Facebook images may require permission or login. You may need to:
1. Log into Facebook
2. Navigate to their page
3. Right-click images → Save Image As
4. Convert to WebP format
5. Place in `assets/images/` directory

