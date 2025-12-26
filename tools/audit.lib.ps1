Set-StrictMode -Version Latest

# Shared audit helpers (dot-source this file)
$script:AuditLines     = New-Object System.Collections.Generic.List[string]
$script:AuditFailCount = 0

function AddLine([string]$s = "") {
  $script:AuditLines.Add($s) | Out-Null
}

function Expect(
  [string]$name,
  [bool]$condition,
  [string]$onFail = ""
) {
  if ($condition) {
    AddLine ("- [PASS] " + $name)
  } else {
    $script:AuditFailCount++
    if ([string]::IsNullOrWhiteSpace($onFail)) { $onFail = "Expectation failed" }
    AddLine ("- [FAIL] " + $name + " -- " + $onFail)
  }
}

function ResetAudit() {
  $script:AuditLines.Clear()
  $script:AuditFailCount = 0
}

function WriteAuditReport([string]$path) {
  $stamp  = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  $header = @(
    "# AUDIT REPORT",
    "",
    ("Generated: " + $stamp),
    ("Failures: "  + $script:AuditFailCount),
    ""
  )

  $out = ($header + $script:AuditLines.ToArray()) -join "`r`n"
  [System.IO.File]::WriteAllText($path, ($out.TrimEnd() + "`r`n"), (New-Object System.Text.UTF8Encoding($false)))
  Write-Host ("Wrote: " + $path) -ForegroundColor Cyan

  return $script:AuditFailCount
}
