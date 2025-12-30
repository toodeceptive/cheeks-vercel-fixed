#!/usr/bin/env python3
"""
Convert images to WebP format for Cheeks Bar & Grill website.
Place your downloaded images in a folder and run this script.
"""

import os
from pathlib import Path
try:
    from PIL import Image
except ImportError:
    print("Pillow is required. Install with: pip install Pillow")
    exit(1)

# Image mappings: Facebook image → Website filename
IMAGE_MAPPINGS = {
    "sign.webp": "sign.webp",
    "staff.webp": "staff.webp", 
    "food-basket.webp": "food-basket.webp",
    "chef-chili.webp": "chef-chili.webp",
    "interior.webp": "interior.webp",
    "patrons.webp": "patrons.webp"
}

def convert_to_webp(input_path, output_path, quality=85):
    """Convert an image to WebP format."""
    try:
        img = Image.open(input_path)
        # Convert RGBA to RGB if necessary
        if img.mode in ('RGBA', 'LA', 'P'):
            rgb_img = Image.new('RGB', img.size, (15, 17, 19))  # Dark background
            if img.mode == 'P':
                img = img.convert('RGBA')
            rgb_img.paste(img, mask=img.split()[-1] if img.mode in ('RGBA', 'LA') else None)
            img = rgb_img
        elif img.mode != 'RGB':
            img = img.convert('RGB')
        
        img.save(output_path, 'WEBP', quality=quality, optimize=True)
        return True
    except Exception as e:
        print(f"Error converting {input_path}: {e}")
        return False

def main():
    assets_dir = Path("assets/images")
    assets_dir.mkdir(parents=True, exist_ok=True)
    
    print("Cheeks Bar & Grill - Image Converter")
    print("=" * 50)
    print("\nThis script converts images to WebP format.")
    print("\nInstructions:")
    print("1. Download images from Facebook")
    print("2. Place them in the current directory")
    print("3. Rename them to match the expected names (or let the script find them)")
    print("\nExpected image names:")
    for name in IMAGE_MAPPINGS.keys():
        print(f"  - {name}")
    
    print("\n" + "=" * 50)
    
    # Look for images in current directory
    current_dir = Path(".")
    image_extensions = {'.jpg', '.jpeg', '.png', '.webp', '.JPG', '.JPEG', '.PNG', '.WEBP'}
    
    found_images = []
    for ext in image_extensions:
        found_images.extend(list(current_dir.glob(f"*{ext}")))
    
    if not found_images:
        print("\nNo images found in current directory.")
        print("Please download images from Facebook and place them here.")
        return
    
    print(f"\nFound {len(found_images)} image(s):")
    for img in found_images:
        print(f"  - {img.name}")
    
    # Convert images
    converted = 0
    for img_path in found_images:
        # Try to match filename or use a generic name
        output_name = img_path.stem.lower().replace(' ', '-').replace('_', '-')
        if not output_name.endswith('.webp'):
            output_name += '.webp'
        
        output_path = assets_dir / output_name
        
        if img_path.suffix.lower() == '.webp':
            # Already WebP, just copy
            import shutil
            shutil.copy2(img_path, output_path)
            print(f"✓ Copied {img_path.name} → {output_path.name}")
            converted += 1
        else:
            # Convert to WebP
            if convert_to_webp(img_path, output_path):
                print(f"✓ Converted {img_path.name} → {output_path.name}")
                converted += 1
    
    print(f"\n{'=' * 50}")
    print(f"Converted {converted} image(s) to assets/images/")
    print("\nNext steps:")
    print("1. Review the images in assets/images/")
    print("2. Rename them if needed to match: sign.webp, staff.webp, etc.")
    print("3. The website will automatically display them!")

if __name__ == "__main__":
    main()


