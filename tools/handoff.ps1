param(
  [string]$Project = (Join-Path $env:USERPROFILE "Downloads\cheeks-vercel-fixed"),
  [string]$BaseUrl = "https://cheeks-bar-and-grill.vercel.app"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (!(Test-Path $Project)) { throw "Missing project folder: $Project" }
Set-Location $Project

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
function WriteUtf8NoBom([string]$path, [string]$content) {
  $dir = Split-Path $path -Parent
  if ($dir -and !(Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  [System.IO.File]::WriteAllText($path, ($content.TrimEnd() + "`r`n"), $utf8NoBom)
}

$stamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
$outMd = New-Object System.Collections.Generic.List[string]

function Add([string]$s="") { $outMd.Add($s) | Out-Null }

Add "# CHEEKS — HANDOFF SNAPSHOT"
Add ""
Add ("Generated: " + $stamp)
Add ("BaseUrl: " + $BaseUrl)
Add ""

# Versions
Add "## Versions"
try { Add ("- PowerShell: " + $PSVersionTable.PSVersion.ToString()) } catch {}
try { Add ("- Node: " + (& node -v 2>$null)) } catch {}
try { Add ("- npm: " + (& npm -v 2>$null)) } catch {}
try { Add ("- Vercel CLI: " + (& npx --yes vercel@latest --version 2>$null)) } catch {}
Add ""

# Key file hashes
$hashesPath = Join-Path $Project "HANDOFF_HASHES.txt"
$hashLines = New-Object System.Collections.Generic.List[string]
function HashFile([string]$rel) {
  $p = Join-Path $Project $rel
  if (Test-Path $p) {
    $h = (Get-FileHash $p -Algorithm SHA256).Hash
    $hashLines.Add(("{0}  {1}" -f $h, $rel)) | Out-Null
  } else {
    $hashLines.Add(("[MISSING]  {0}" -f $rel)) | Out-Null
  }
}
HashFile "index.html"
HashFile "vercel.json"
HashFile "robots.txt"
HashFile "sitemap.xml"
HashFile "site.webmanifest"
HashFile "tools\audit.ps1"
HashFile "tools\audit.lib.ps1"
HashFile "AUDIT_REPORT.md"
HashFile "assets\images\favicon.ico"
HashFile "assets\images\apple-touch-icon.png"
HashFile "assets\images\og.png"
WriteUtf8NoBom $hashesPath ($hashLines -join "`r`n")

Add "## File Hashes (SHA256)"
Add ""
Add "```"
Add (Get-Content $hashesPath | Out-String).TrimEnd()
Add "```"
Add ""

# Include key files (trimmed)
function AddFileBlock([string]$title, [string]$rel, [int]$maxChars = 20000) {
  $p = Join-Path $Project $rel
  Add ("## " + $title)
  Add ""
  if (!(Test-Path $p)) { Add ("[MISSING] " + $rel); Add ""; return }
  $txt = [System.IO.File]::ReadAllText($p)
  if ($txt.Length -gt $maxChars) { $txt = $txt.Substring(0, $maxChars) + "`r`n...[TRUNCATED]..." }
  Add ("**Path:** " + $rel)
  Add ""
  Add "```"
  Add $txt.TrimEnd()
  Add "```"
  Add ""
}

AddFileBlock "index.html" "index.html"
AddFileBlock "vercel.json" "vercel.json"
AddFileBlock "robots.txt" "robots.txt"
AddFileBlock "sitemap.xml" "sitemap.xml"
AddFileBlock "site.webmanifest" "site.webmanifest"
AddFileBlock "tools/audit.ps1" "tools\audit.ps1"
AddFileBlock "tools/audit.lib.ps1" "tools\audit.lib.ps1"
AddFileBlock "AUDIT_REPORT.md" "AUDIT_REPORT.md"

# Live proofs
Add "## Live Proofs (headers)"
Add ""
try {
  $hdr = (curl.exe -sS -I ($BaseUrl + "/") | Out-String).TrimEnd()
  Add "```"
  Add $hdr
  Add "```"
} catch {
  Add ("[ERROR] " + $_.Exception.Message)
}
Add ""

Add "## Live Proofs (favicon)"
Add ""
try {
  $fav = (curl.exe -sS -I ($BaseUrl + "/favicon.ico") | Out-String).TrimEnd()
  Add "```"
  Add $fav
  Add "```"
} catch {
  Add ("[ERROR] " + $_.Exception.Message)
}
Add ""

# Write snapshot
$snapPath = Join-Path $Project "HANDOFF_SNAPSHOT.md"
WriteUtf8NoBom $snapPath ($outMd -join "`r`n")

Write-Host ("Wrote: " + $snapPath) -ForegroundColor Green
Write-Host ("Wrote: " + $hashesPath) -ForegroundColor Green
