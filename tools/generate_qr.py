#!/usr/bin/env python3
"""
Generate QR code for Cheeks Bar & Grill with source tracking parameter.
Usage: python tools/generate_qr.py
"""

from pathlib import Path
import sys

try:
    import qrcode
    from PIL import Image
except ImportError:
    print("ERROR: Required libraries not installed.")
    print("Install with: pip install qrcode[pil]")
    print("\nAlternatively, use an online QR code generator:")
    print("  URL: https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent")
    print("  Save to: assets/images/qr-table-tent.png")
    sys.exit(1)

# Target URL with source parameter
URL = "https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent"

# Output paths
BASE_DIR = Path(__file__).parent.parent
PNG_PATH = BASE_DIR / "assets" / "images" / "qr-table-tent.png"
PDF_PATH = Path.home() / "Desktop" / "cheeks-bar-and-grill-qr.pdf"

def generate_qr_code():
    """Generate QR code image"""
    print(f"Generating QR code for: {URL}")
    
    # Create QR code instance
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(URL)
    qr.make(fit=True)
    
    # Create image
    img = qr.make_image(fill_color="black", back_color="white")
    
    # Save PNG
    PNG_PATH.parent.mkdir(parents=True, exist_ok=True)
    img.save(PNG_PATH)
    print(f"[OK] Saved PNG: {PNG_PATH}")
    print(f"     Size: {PNG_PATH.stat().st_size} bytes")
    
    # Note: PDF generation would require reportlab or similar
    # For now, user can convert PNG to PDF manually or use online tool
    print(f"\nFor PDF version:")
    print(f"  1. Open {PNG_PATH}")
    print(f"  2. Print to PDF or use online converter")
    print(f"  3. Save to: {PDF_PATH}")
    
    return PNG_PATH

if __name__ == "__main__":
    try:
        generate_qr_code()
        print("\n[SUCCESS] QR code generated successfully!")
        print(f"\nNext steps:")
        print(f"1. Test by scanning the QR code")
        print(f"2. Verify URL includes ?src=qr-table-tent")
        print(f"3. Update PATCH_QUEUE.md to mark PATCH-004 as complete")
    except Exception as e:
        print(f"ERROR: {e}")
        sys.exit(1)
