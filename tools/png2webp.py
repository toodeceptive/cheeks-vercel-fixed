from pathlib import Path
from PIL import Image

base = Path("assets/images")
pairs = [("hero.png","hero.webp"), ("og.png","og.webp")]

for src, dst in pairs:
    srcp = base / src
    dstp = base / dst
    im = Image.open(srcp).convert("RGBA")
    im.save(dstp, "WEBP", quality=82, method=6)
    print(f"wrote {dstp} ({dstp.stat().st_size} bytes)")