# Cheeks Bar & Grill - Build Audit

Generated: 2025-12-25 19:11:59

## Required files present
- index.html
- robots.txt
- sitemap.xml
- vercel.json
- assets/images/hero.png
- assets/images/og.png
- assets/images/hero.webp
- assets/images/og.webp

## Encoding / BOM check
- robots.txt: first3bytes=85 115 101 => no-BOM
- sitemap.xml: first3bytes=60 63 120 => no-BOM
- vercel.json: first3bytes=123 13 10 => no-BOM
- index.html: first3bytes=60 33 100 => no-BOM

## SEO / Meta
- **canonical**: PASS - found='https://cheeks-bar-and-grill.vercel.app/' expected='https://cheeks-bar-and-grill.vercel.app/'
- **og:url**: PASS - found='https://cheeks-bar-and-grill.vercel.app/' expected='https://cheeks-bar-and-grill.vercel.app/'
- **og:image png**: PASS - found='https://cheeks-bar-and-grill.vercel.app/assets/images/og.png' expected='https://cheeks-bar-and-grill.vercel.app/assets/images/og.png'

## Schema.org JSON-LD
- JSON-LD: NOT FOUND

## Speed Insights (static)
- **tag present in HTML**: PASS - contains '/_vercel/speed-insights/script.js'

## Hero (LCP) hints
- **preload hero.webp**: PASS - index.html preloads /assets/images/hero.webp
- **hero img eager**: PASS - hero <img> has loading="eager"
- **hero img fetchpriority**: PASS - hero <img> has fetchpriority="high"

## HTML integrity (common breakpoints)
- **hero tag closes**: PASS - first ~600 chars after hero src contains a closing '>'

## Local file hashes (progress tracking)
- index.html: sha256=cb6e935fa2919fcaa67af2ad1b9471add5bafc3d5e986c79dab277ab6ae268b2
- robots.txt: sha256=2ada36e4fb99826a98585b76ec8f19f3a7b7dd3ba87e0ac1704f948ebc4c1a23
- sitemap.xml: sha256=71d5797bbb15fcf8171e1bbbc2c3fd0945ef91e1829c0efb6974e748ebbef26e
- vercel.json: sha256=d5b225d610159ad41eee9409d1e8e303966fd36b73b4ee443e659449cc005e11

## Live checks
- **live HTML has SI tag**: PASS - served HTML includes speed insights tag
- **SI script 200**: PASS - HEAD returns 200
- **SI content-type js**: PASS - content-type is application/javascript
- **robots has Sitemap line**: PASS - robots.txt includes Sitemap
- **live hero eager**: PASS - served HTML has loading="eager"
- **live hero fetchpriority**: PASS - served HTML has fetchpriority="high"
- **hero.webp 200**: PASS - HEAD returns 200
- **hero.webp content-type webp**: PASS - content-type is image/webp
