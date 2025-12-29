param(
  [Parameter(Mandatory=$true)]
  [ValidateSet("audit","handoff","status")]
  [string]$Task,

  [string]$BaseUrl = "https://cheeks-bar-and-grill.vercel.app"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Find-RepoRoot {
  $d = Get-Location
  while ($true) {
    if (Test-Path (Join-Path $d ".git")) { return $d }
    $p = Split-Path $d -Parent
    if ($p -eq $d) { throw "Not inside a git repo. cd into cheeks-vercel-fixed first." }
    $d = $p
  }
}

$root = Find-RepoRoot
Set-Location $root

switch ($Task) {
  "status" {
    git status
    git log -n 5 --oneline
  }
  "audit" {
    pwsh .\tools\audit.ps1 -BaseUrl $BaseUrl
    Get-Content .\AUDIT_REPORT.md -Raw
  }
  "handoff" {
    pwsh .\tools\handoff.ps1 -Project (Get-Location) -BaseUrl $BaseUrl
  }
}