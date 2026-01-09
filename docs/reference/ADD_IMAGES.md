# Adding Images to Cheeks Bar & Grill Website

## Step 1: Download Images from Facebook

1. Go to: <https://www.facebook.com/profile.php?id=61571389349445&sk=about>
2. Browse through the photos on the Facebook page
3. Download the following images (right-click → Save Image As)

### Required Images

1. **sign.webp** - The outdoor sign photo (for hero section)
2. **staff.webp** - Photo of Ryan and Angela Thomas / staff (for about section)
3. **food-basket.webp** - Photo of food basket with cheese curds
4. **chef-chili.webp** - Photo of chef with chili bowl
5. **interior.webp** - Interior shots of the bar
6. **patrons.webp** - Photo of patrons/customers

## Step 2: Convert to WebP Format

WebP format provides better compression and faster loading. You can:

### Option A: Use Online Converter

- Go to <https://cloudconvert.com/png-to-webp> or <https://convertio.co/png-webp/>
- Upload your images and convert to WebP

### Option B: Use Python Script (if you have Python installed)

Run the provided `convert_images.py` script in this directory

## Step 3: Place Images

1. Save all converted .webp files to: `assets/images/`
2. Make sure filenames match exactly:
   - sign.webp
   - staff.webp
   - food-basket.webp
   - chef-chili.webp
   - interior.webp
   - patrons.webp

## Step 4: Verify

Once images are in place, the website will automatically:

- Display the sign in the hero section
- Show staff photo in the about section
- Load all images in the gallery section

Images that don't exist will be gracefully skipped (no broken images).
