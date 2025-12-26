param(
  [string]$Alias = "https://cheeks-bar-and-grill.vercel.app"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Resolve project root from this script location
$Project = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent
Set-Location $Project

function Sha256([string]$p) { (Get-FileHash -Algorithm SHA256 -Path $p).Hash.ToLower() }
function First3Bytes([string]$p) { (Get-Content -Encoding Byte -TotalCount 3 -Path $p) -join " " }
function ReadAll([string]$p) { [System.IO.File]::ReadAllText((Resolve-Path $p)) }

function WriteUtf8Bom([string]$p, [string]$t) {
  $utf8Bom = New-Object System.Text.UTF8Encoding($true)  # BOM for WinPS 5.1 safety
  [System.IO.File]::WriteAllText($p, $t, $utf8Bom)
}

function AsText([object]$x) {
  if ($null -eq $x) { return "" }
  if ($x -is [array]) { return ($x -join "`n") }
  return [string]$x
}

$report = New-Object System.Collections.Generic.List[string]
function AddLine([string]$s){ $report.Add($s) | Out-Null }

function Expect([string]$name, [bool]$ok, [string]$detail){
  $status = if($ok){"PASS"}else{"WARN"}
  AddLine ("- **{0}**: {1} - {2}" -f $name, $status, $detail)
}

AddLine "# Cheeks Bar & Grill - Build Audit"
AddLine ""
AddLine ("Generated: {0}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"))
AddLine ""

# ---------- Required files ----------
$must = @(
  "index.html","robots.txt","sitemap.xml","vercel.json",
  "assets/images/hero.png","assets/images/og.png",
  "assets/images/hero.webp","assets/images/og.webp"
)

$missing = @()
foreach($m in $must){ if(!(Test-Path $m)){ $missing += $m } }

if($missing.Count -gt 0){
  AddLine "## Missing required files"
  $missing | ForEach-Object { AddLine "- $_" }
  $out = Join-Path $Project "AUDIT_REPORT.md"
  WriteUtf8Bom $out ($report -join "`r`n")
  throw "Missing required files. See: $out"
} else {
  AddLine "## Required files present"
  $must | ForEach-Object { AddLine "- $_" }
  AddLine ""
}

# ---------- Encoding / BOM ----------
AddLine "## Encoding / BOM check"
foreach($f in @("robots.txt","sitemap.xml","vercel.json","index.html")){
  $b = First3Bytes $f
  $hasBom = ($b -eq "239 187 191")
  AddLine ("- {0}: first3bytes={1} => {2}" -f $f, $b, ($(if($hasBom){"BOM"}else{"no-BOM"})))
}
AddLine ""

# ---------- Parse HTML ----------
$html = ReadAll "index.html"

AddLine "## SEO / Meta"
$canon = [regex]::Match($html,'<link\s+rel="canonical"\s+href="([^"]+)"\s*/?>','IgnoreCase').Groups[1].Value
Expect "canonical" ([bool]($canon -eq "$Alias/")) ("found='{0}' expected='{1}'" -f $canon, "$Alias/")

$ogUrl = [regex]::Match($html,'property="og:url"\s+content="([^"]+)"','IgnoreCase').Groups[1].Value
Expect "og:url" ([bool]($ogUrl -eq "$Alias/")) ("found='{0}' expected='{1}'" -f $ogUrl, "$Alias/")

$ogImg = [regex]::Match($html,'property="og:image"\s+content="([^"]+)"','IgnoreCase').Groups[1].Value
Expect "og:image png" ([bool]($ogImg -eq "$Alias/assets/images/og.png")) ("found='{0}' expected='{1}'" -f $ogImg, "$Alias/assets/images/og.png")
AddLine ""

AddLine "## Schema.org JSON-LD"
$ld = [regex]::Match($html,'<script\s+type="application/ld\+json">\s*(\{.*?\})\s*</script>','Singleline').Groups[1].Value
if($ld){
  $has58241 = [bool]($ld -match '"streetAddress"\s*:\s*"58241 E Wausau Ave"')
  $hasOld   = [bool]($ld -match '158241')
  Expect "streetAddress=58241" $has58241 "JSON-LD contains correct streetAddress"
  Expect "no old address" ([bool](-not $hasOld)) "JSON-LD contains no '158241'"
} else {
  AddLine "- JSON-LD: NOT FOUND"
}
AddLine ""

AddLine "## Speed Insights (static)"
$si = "/_vercel/speed-insights/script.js"
$hasSi = [bool]($html -match [regex]::Escape($si))
Expect "tag present in HTML" $hasSi ("contains '{0}'" -f $si)
AddLine ""

AddLine "## Hero (LCP) hints"
$hasPreload = [regex]::Match($html,'<link\s+rel="preload"\s+as="image"\s+href="/assets/images/hero\.webp"[^>]*>','IgnoreCase').Success
Expect "preload hero.webp" ([bool]$hasPreload) "index.html preloads /assets/images/hero.webp"

$pic = [regex]::Match($html,'<picture>.*?<img\b[^>]*src="/assets/images/hero\.png"[^>]*>.*?</picture>','Singleline').Value
if($pic){
  $eager = [bool]($pic -match 'loading="eager"')
  $fp    = [bool]($pic -match 'fetchpriority="high"')
  Expect "hero img eager" $eager 'hero <img> has loading="eager"'
  Expect "hero img fetchpriority" $fp 'hero <img> has fetchpriority="high"'
} else {
  AddLine "- hero picture block not found"
}
AddLine ""

AddLine "## HTML integrity (common breakpoints)"
$heroPos = $html.IndexOf('src="/assets/images/hero')
if($heroPos -ge 0){
  $slice = $html.Substring($heroPos, [Math]::Min(600, $html.Length - $heroPos))
  $close = $slice.IndexOf(">")
  Expect "hero tag closes" ([bool]($close -ge 0)) "first ~600 chars after hero src contains a closing '>'"
} else {
  AddLine "- hero reference not found"
}
AddLine ""

AddLine "## Local file hashes (progress tracking)"
foreach($f in @("index.html","robots.txt","sitemap.xml","vercel.json")){
  AddLine ("- {0}: sha256={1}" -f $f, (Sha256 $f))
}
AddLine ""

# ---------- Live checks ----------
AddLine "## Live checks"
if(!(Get-Command curl.exe -ErrorAction SilentlyContinue)){
  AddLine "- curl.exe not found; skipping live checks"
} else {
  $liveText = AsText (& curl.exe -sS -H "Cache-Control: no-cache" "$Alias/")
  Expect "live HTML has SI tag" ([bool]($liveText -match [regex]::Escape($si))) "served HTML includes speed insights tag"

  $siHeadText = AsText (& curl.exe -sS -I "$Alias$si")
  Expect "SI script 200" ([bool]($siHeadText -match 'HTTP/.*\s200\s')) "HEAD returns 200"
  Expect "SI content-type js" ([bool]($siHeadText -match 'Content-Type:\s*application/javascript')) "content-type is application/javascript"

  $robotsText = AsText (& curl.exe -sS "$Alias/robots.txt")
  Expect "robots has Sitemap line" ([bool]($robotsText -match 'Sitemap:\s*https://')) "robots.txt includes Sitemap"

  # Hero live checks
  Expect "live hero eager" ([bool]($liveText -match 'loading="eager"')) 'served HTML has loading="eager"'
  Expect "live hero fetchpriority" ([bool]($liveText -match 'fetchpriority="high"')) 'served HTML has fetchpriority="high"'

  $heroHeadText = AsText (& curl.exe -sS -I "$Alias/assets/images/hero.webp")
  Expect "hero.webp 200" ([bool]($heroHeadText -match 'HTTP/.*\s200\s')) "HEAD returns 200"
  Expect "hero.webp content-type webp" ([bool]($heroHeadText -match 'Content-Type:\s*image/webp')) "content-type is image/webp"
}

AddLine ""
$out = Join-Path $Project "AUDIT_REPORT.md"
WriteUtf8Bom $out ($report -join "`r`n")
Write-Host ("Wrote: {0}" -f $out) -ForegroundColor Green