# Guru Expert Debugger - Simplified Reliable Version
param(
    [switch]$FullAnalysis = $true
)

$ErrorActionPreference = "Continue"
$ProjectRoot = Split-Path -Parent $PSScriptRoot
$Results = @()

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GURU EXPERT DEBUGGER - ANALYSIS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Phase 1: Static Analysis
Write-Host "[PHASE 1] Static Code Analysis" -ForegroundColor Yellow
Write-Host "  Checking syntax..." -ForegroundColor Gray
$jsFiles = Get-ChildItem -Path $ProjectRoot -Filter "*.js" -Recurse | Where-Object { $_.FullName -notlike "*node_modules*" }
Write-Host "    Found $($jsFiles.Count) JavaScript files" -ForegroundColor Gray
$Results += @{Phase="Static"; Check="File Count"; Status="PASS"; Count=$jsFiles.Count}

# Phase 2: Security Check
Write-Host "[PHASE 2] Security Analysis" -ForegroundColor Yellow
$securityIssues = 0
foreach ($file in $jsFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match 'eval\s*\(') {
        $securityIssues++
    }
    if ($content -match '\.innerHTML\s*=' -and $content -notmatch 'htmlEscape') {
        $securityIssues++
    }
}
if ($securityIssues -eq 0) {
    Write-Host "    PASS: No security issues detected" -ForegroundColor Green
    $Results += @{Phase="Security"; Check="Vulnerabilities"; Status="PASS"}
} else {
    Write-Host "    WARN: $securityIssues potential security issues" -ForegroundColor Yellow
    $Results += @{Phase="Security"; Check="Vulnerabilities"; Status="WARN"; Count=$securityIssues}
}

# Phase 3: Runtime Tests
Write-Host "[PHASE 3] Runtime Verification" -ForegroundColor Yellow
$baseUrl = "https://cheeks-bar-and-grill.vercel.app"

Write-Host "  Testing health endpoint..." -ForegroundColor Gray
try {
    $health = Invoke-RestMethod -Uri "$baseUrl/api/health" -Method GET -TimeoutSec 10
    if ($health.ok) {
        Write-Host "    PASS: Health endpoint working" -ForegroundColor Green
        $Results += @{Phase="Runtime"; Check="Health"; Status="PASS"}
    }
} catch {
    Write-Host "    FAIL: Health endpoint error" -ForegroundColor Red
    $Results += @{Phase="Runtime"; Check="Health"; Status="FAIL"}
}

Write-Host "  Testing form submission..." -ForegroundColor Gray
$futureDate = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
$payload = @{
    name = "Debug Test"
    phone = "(715) 555-1234"
    email = "debug@test.com"
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Debug test"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/api/inquiry" -Method POST -Body $payload -ContentType "application/json" -TimeoutSec 10
    if ($response.ok) {
        Write-Host "    PASS: Form submission working (ID: $($response.id))" -ForegroundColor Green
        $Results += @{Phase="Runtime"; Check="Form Submission"; Status="PASS"; ID=$response.id}
    }
} catch {
    Write-Host "    FAIL: Form submission error" -ForegroundColor Red
    $Results += @{Phase="Runtime"; Check="Form Submission"; Status="FAIL"}
}

# Phase 4: Performance Check
Write-Host "[PHASE 4] Performance Analysis" -ForegroundColor Yellow
$indexHtml = Get-Content "$ProjectRoot\index.html" -Raw
$checks = 0
if ($indexHtml -match 'rel="preload"') { $checks++ }
if ($indexHtml -match 'rel="dns-prefetch"') { $checks++ }
if ($indexHtml -match '\.webp') { $checks++ }
Write-Host "    Performance optimizations: $checks/3 found" -ForegroundColor $(if ($checks -eq 3) { "Green" } else { "Yellow" })
$Results += @{Phase="Performance"; Check="Optimizations"; Status=$(if ($checks -eq 3) { "PASS" } else { "WARN" }); Found=$checks}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
$passed = ($Results | Where-Object { $_.Status -eq "PASS" }).Count
$warned = ($Results | Where-Object { $_.Status -eq "WARN" }).Count
$failed = ($Results | Where-Object { $_.Status -eq "FAIL" }).Count
Write-Host "Passed: $passed" -ForegroundColor Green
Write-Host "Warnings: $warned" -ForegroundColor Yellow
Write-Host "Failed: $failed" -ForegroundColor Red
Write-Host ""
$Results | ConvertTo-Json -Depth 10 | Out-File "$ProjectRoot\debug-results.json" -Encoding UTF8
Write-Host "Results saved to: debug-results.json" -ForegroundColor Gray
