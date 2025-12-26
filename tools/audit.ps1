param(
  [string]$BaseUrl = "https://cheeks-bar-and-grill.vercel.app"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Here    = Split-Path -Parent $MyInvocation.MyCommand.Path
$Project = Split-Path -Parent $Here

. (Join-Path $Here "audit.lib.ps1")
ResetAudit

function Rx([string]$pattern) { return [regex]::new($pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase) }

try {
  $indexPath = Join-Path $Project "index.html"
  $html = [System.IO.File]::ReadAllText($indexPath)

  AddLine "## Core (HTML)"
  $rxCanonical = Rx('<link\b[^>]*\brel\s*=\s*("canonical"|''canonical'')')
  $rxDesc      = Rx('<meta\b[^>]*\bname\s*=\s*("description"|''description'')')
  $rxRobots    = Rx('<meta\b[^>]*\bname\s*=\s*("robots"|''robots'')')
  $rxManifest  = Rx('<link\b[^>]*\brel\s*=\s*("manifest"|''manifest'')')

  Expect "has canonical" ($rxCanonical.IsMatch($html)) "missing canonical"
  Expect "has meta description" ($rxDesc.IsMatch($html)) "missing meta description"
  Expect "has robots meta" ($rxRobots.IsMatch($html)) "missing robots meta"
  Expect "has manifest link" ($rxManifest.IsMatch($html)) "missing manifest link"

  Expect "has SEO marker block" ([bool]($html -match '<!-- SEO:BEGIN -->' -and $html -match '<!-- SEO:END -->')) "missing SEO marker block"

  AddLine ""
  AddLine "## SEO (robots/sitemap/manifest)"
  Expect "robots.txt exists" (Test-Path (Join-Path $Project "robots.txt")) "robots.txt missing"
  Expect "sitemap.xml exists" (Test-Path (Join-Path $Project "sitemap.xml")) "sitemap.xml missing"
  Expect "site.webmanifest exists" (Test-Path (Join-Path $Project "site.webmanifest")) "site.webmanifest missing"
} catch {
  AddLine ("Audit HTML/SEO error: " + $_.Exception.Message)
  $script:AuditFailCount++
}

try {
  AddLine ""
  AddLine "## Live (headers)"
  $h = (curl.exe -sS -I ($BaseUrl + "/") | Out-String)

  Expect "CSP present" ([bool]($h -match 'Content-Security-Policy:')) "missing CSP"
  Expect "HSTS present" ([bool]($h -match 'Strict-Transport-Security:')) "missing HSTS"
  Expect "nosniff present" ([bool]($h -match 'X-Content-Type-Options:\s*nosniff')) "missing nosniff"
  Expect "XFO deny present" ([bool]($h -match 'X-Frame-Options:\s*DENY')) "missing XFO DENY"
  Expect "Referrer-Policy present" ([bool]($h -match 'Referrer-Policy:')) "missing Referrer-Policy"
} catch {
  AddLine ("Live header check error: " + $_.Exception.Message)
  $script:AuditFailCount++
}

try {
  AddLine ""
  AddLine "## Live (favicon/manifest)"
  $fav = (curl.exe -sS -I ($BaseUrl + "/favicon.ico") | Out-String)
  Expect "favicon is ICO" ([bool]($fav -match 'Content-Type:\s*image/vnd\.microsoft\.icon')) "favicon content-type not ICO"

  $man = (curl.exe -sS -I ($BaseUrl + "/site.webmanifest") | Out-String)
  Expect "manifest served" ([bool]($man -match 'HTTP/\d\.\d\s+200')) "manifest not 200"
} catch {
  AddLine ("Live favicon/manifest check error: " + $_.Exception.Message)
  $script:AuditFailCount++
}

try {
  $reportPath = Join-Path $Project "AUDIT_REPORT.md"
  $fails = WriteAuditReport $reportPath
  if ($fails -gt 0) { Write-Host ("AUDIT FAILURES: " + $fails) -ForegroundColor Red; exit 1 }
  Write-Host "AUDIT OK" -ForegroundColor Green
  exit 0
} catch {
  Write-Host ("Audit crashed: " + $_.Exception.Message) -ForegroundColor Red
  exit 2
}
