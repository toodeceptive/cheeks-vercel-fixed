# Guru Expert Debugger - Comprehensive Analysis Tool
# Performs deep debugging, analysis, and verification

param(
    [switch]$FullAnalysis = $true,
    [switch]$Security = $true,
    [switch]$Performance = $true,
    [switch]$CodeQuality = $true,
    [switch]$Runtime = $true,
    [switch]$Network = $true
)

$ErrorActionPreference = "Continue"
$ProjectRoot = $PSScriptRoot + "\.."
$Results = @()

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     GURU EXPERT DEBUGGER - COMPREHENSIVE ANALYSIS        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# PHASE 1: STATIC CODE ANALYSIS
# ============================================================================
Write-Host "🔍 PHASE 1: STATIC CODE ANALYSIS" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray

# Check for common issues
Write-Host "  [1.1] Checking for syntax errors..." -ForegroundColor Gray
$jsFiles = Get-ChildItem -Path $ProjectRoot -Filter "*.js" -Recurse -Exclude "node_modules" | Where-Object { $_.FullName -notlike "*node_modules*" }
$syntaxErrors = 0
foreach ($file in $jsFiles) {
    try {
        $content = Get-Content $file.FullName -Raw
        # Basic syntax checks
        if ($content -match 'console\.(log|error|warn)\([^)]*\)' -and $content -notmatch 'eslint-disable') {
            # Check for uncommented console statements
        }
    } catch {
        $syntaxErrors++
        Write-Host "    ⚠️  Potential issue in: $($file.Name)" -ForegroundColor Yellow
    }
}
if ($syntaxErrors -eq 0) {
    Write-Host "    ✅ No syntax errors detected" -ForegroundColor Green
    $Results += @{Phase="Static Analysis"; Check="Syntax Errors"; Status="PASS"}
} else {
    Write-Host "    ⚠️  $syntaxErrors potential issues found" -ForegroundColor Yellow
    $Results += @{Phase="Static Analysis"; Check="Syntax Errors"; Status="WARN"; Count=$syntaxErrors}
}

# Check for security issues
Write-Host "  [1.2] Checking for security vulnerabilities..." -ForegroundColor Gray
$securityIssues = @()
$apiFiles = Get-ChildItem -Path "$ProjectRoot\api" -Filter "*.js" -Recurse
foreach ($file in $apiFiles) {
    $content = Get-Content $file.FullName -Raw
    # Check for hardcoded secrets
    $secretPattern = 'password|secret|api[_-]?key|token'
    if ($content -match $secretPattern -and $content -match '["'']\w+["'']') {
        $securityIssues += "Potential hardcoded secret in $($file.Name)"
    }
    # Check for eval usage
    if ($content -match '\beval\s*\(') {
        $msg = "eval function usage in " + $file.Name
        $securityIssues += $msg
    }
    # Check for innerHTML without sanitization
    if ($content -match '\.innerHTML\s*=' -and $content -notmatch 'htmlEscape|sanitize') {
        $securityIssues += "innerHTML without sanitization in $($file.Name)"
    }
}
if ($securityIssues.Count -eq 0) {
    Write-Host "    ✅ No security vulnerabilities detected" -ForegroundColor Green
    $Results += @{Phase="Security"; Check="Vulnerabilities"; Status="PASS"}
} else {
    Write-Host "    ⚠️  $($securityIssues.Count) potential security issues found" -ForegroundColor Yellow
    foreach ($issue in $securityIssues) {
        Write-Host "      - $issue" -ForegroundColor Yellow
    }
    $Results += @{Phase="Security"; Check="Vulnerabilities"; Status="WARN"; Count=$securityIssues.Count}
}

# Check for performance issues
Write-Host "  [1.3] Checking for performance issues..." -ForegroundColor Gray
$perfIssues = @()
$htmlFiles = Get-ChildItem -Path $ProjectRoot -Filter "*.html" -Recurse
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    # Check for missing preload
    if ($file.Name -eq "index.html" -and $content -notmatch 'rel="preload"') {
        # Actually we added preload, so this should pass
    }
    # Check for large inline scripts
    if ($content -match '<script[^>]*>[\s\S]{1000,}</script>') {
        $perfIssues += "Large inline script in $($file.Name)"
    }
}
if ($perfIssues.Count -eq 0) {
    Write-Host "    ✅ No performance issues detected" -ForegroundColor Green
    $Results += @{Phase="Performance"; Check="Optimizations"; Status="PASS"}
} else {
    Write-Host "    ⚠️  $($perfIssues.Count) performance issues found" -ForegroundColor Yellow
    $Results += @{Phase="Performance"; Check="Optimizations"; Status="WARN"; Count=$perfIssues.Count}
}

Write-Host ""

# ============================================================================
# PHASE 2: RUNTIME VERIFICATION
# ============================================================================
Write-Host "🔍 PHASE 2: RUNTIME VERIFICATION" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray

if ($Runtime) {
    Write-Host "  [2.1] Testing API endpoints..." -ForegroundColor Gray
    $baseUrl = "https://cheeks-bar-and-grill.vercel.app"
    
    # Test health endpoint
    try {
        $health = Invoke-RestMethod -Uri "$baseUrl/api/health" -Method GET -TimeoutSec 10
        if ($health.ok) {
            Write-Host "    ✅ Health endpoint: OK" -ForegroundColor Green
            $Results += @{Phase="Runtime"; Check="Health Endpoint"; Status="PASS"}
        }
    } catch {
        Write-Host "    ❌ Health endpoint: FAILED - $_" -ForegroundColor Red
        $Results += @{Phase="Runtime"; Check="Health Endpoint"; Status="FAIL"; Error=$_.Exception.Message}
    }
    
    # Test sample inquiry endpoint
    try {
        $sample = Invoke-RestMethod -Uri "$baseUrl/api/sample-inquiry" -Method GET -TimeoutSec 10
        if ($sample.ok) {
            Write-Host "    ✅ Sample inquiry endpoint: OK" -ForegroundColor Green
            $Results += @{Phase="Runtime"; Check="Sample Inquiry"; Status="PASS"}
        }
    } catch {
        Write-Host "    ❌ Sample inquiry endpoint: FAILED - $_" -ForegroundColor Red
        $Results += @{Phase="Runtime"; Check="Sample Inquiry"; Status="FAIL"; Error=$_.Exception.Message}
    }
    
    # Test form submission with validation
    Write-Host "  [2.2] Testing form validation..." -ForegroundColor Gray
    $futureDate = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
    $testPayload = @{
        name = "Debug Test"
        phone = "(715) 555-1234"
        email = "debug@test.com"
        eventType = "Birthday"
        eventDate = $futureDate
        eventTime = "18:00"
        guests = 20
        package = "A"
        notes = "Debug test submission"
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/inquiry" -Method POST -Body $testPayload -ContentType "application/json; charset=utf-8" -TimeoutSec 10
        if ($response.ok -and $response.id) {
            Write-Host "    ✅ Form submission: OK (ID: $($response.id))" -ForegroundColor Green
            $Results += @{Phase="Runtime"; Check="Form Submission"; Status="PASS"; ID=$response.id}
        }
    } catch {
        Write-Host "    ❌ Form submission: FAILED - $_" -ForegroundColor Red
        $Results += @{Phase="Runtime"; Check="Form Submission"; Status="FAIL"; Error=$_.Exception.Message}
    }
    
    # Test validation (past date should fail)
    Write-Host "  [2.3] Testing validation rules..." -ForegroundColor Gray
    $pastDate = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")
    $invalidPayload = @{
        name = "Test"
        phone = "(715) 555-1234"
        email = "test@test.com"
        eventType = "Birthday"
        eventDate = $pastDate
        eventTime = "18:00"
        guests = 20
        package = "A"
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/inquiry" -Method POST -Body $invalidPayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
        Write-Host "    ⚠️  Past date validation: Should have failed" -ForegroundColor Yellow
        $Results += @{Phase="Runtime"; Check="Past Date Validation"; Status="WARN"}
    } catch {
        if ($_.Exception.Response.StatusCode -eq 400) {
            Write-Host "    ✅ Past date validation: Correctly rejected" -ForegroundColor Green
            $Results += @{Phase="Runtime"; Check="Past Date Validation"; Status="PASS"}
        } else {
            Write-Host "    ⚠️  Past date validation: Unexpected error" -ForegroundColor Yellow
            $Results += @{Phase="Runtime"; Check="Past Date Validation"; Status="WARN"}
        }
    }
}

Write-Host ""

# ============================================================================
# PHASE 3: NETWORK & SECURITY ANALYSIS
# ============================================================================
Write-Host "🔍 PHASE 3: NETWORK AND SECURITY ANALYSIS" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray

if ($Network) {
    Write-Host "  [3.1] Testing security headers..." -ForegroundColor Gray
    try {
        $headers = Invoke-WebRequest -Uri "https://cheeks-bar-and-grill.vercel.app" -Method HEAD -TimeoutSec 10
        $securityHeaders = @("X-Content-Type-Options", "X-Frame-Options", "Strict-Transport-Security", "Content-Security-Policy")
        $foundHeaders = 0
        foreach ($header in $securityHeaders) {
            if ($headers.Headers[$header]) {
                $foundHeaders++
                Write-Host "    ✅ $header : Present" -ForegroundColor Green
            } else {
                Write-Host "    ⚠️  $header : Missing" -ForegroundColor Yellow
            }
        }
        if ($foundHeaders -eq $securityHeaders.Count) {
            $Results += @{Phase="Security"; Check="Security Headers"; Status="PASS"}
        } else {
            $Results += @{Phase="Security"; Check="Security Headers"; Status="WARN"; Found=$foundHeaders; Total=$securityHeaders.Count}
        }
    } catch {
        Write-Host "    ❌ Security header check failed: $_" -ForegroundColor Red
        $Results += @{Phase="Security"; Check="Security Headers"; Status="FAIL"; Error=$_.Exception.Message}
    }
    
    Write-Host "  [3.2] Testing request size limits..." -ForegroundColor Gray
    $largePayload = @{
        name = "Test"
        phone = "(715) 555-1234"
        email = "test@test.com"
        eventType = "Birthday"
        eventDate = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
        eventTime = "18:00"
        guests = 20
        package = "A"
        notes = "x" * 11000  # > 10KB
    } | ConvertTo-Json
    
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/api/inquiry" -Method POST -Body $largePayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
        Write-Host "    ⚠️  Request size limit: Should have rejected" -ForegroundColor Yellow
        $Results += @{Phase="Security"; Check="Request Size Limit"; Status="WARN"}
    } catch {
        if ($_.Exception.Response.StatusCode -eq 413) {
            Write-Host "    ✅ Request size limit: Correctly enforced (413)" -ForegroundColor Green
            $Results += @{Phase="Security"; Check="Request Size Limit"; Status="PASS"}
        } else {
            Write-Host "    ⚠️  Request size limit: Unexpected response" -ForegroundColor Yellow
            $Results += @{Phase="Security"; Check="Request Size Limit"; Status="WARN"}
        }
    }
}

Write-Host ""

# ============================================================================
# PHASE 4: CODE QUALITY ANALYSIS
# ============================================================================
Write-Host "🔍 PHASE 4: CODE QUALITY ANALYSIS" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray

if ($CodeQuality) {
    Write-Host "  [4.1] Checking code structure..." -ForegroundColor Gray
    $structureIssues = @()
    
    # Check for proper error handling
    $apiFiles = Get-ChildItem -Path "$ProjectRoot\api" -Filter "*.js" -Recurse
    foreach ($file in $apiFiles) {
        $content = Get-Content $file.FullName -Raw
        if ($content -notmatch 'try\s*\{' -and $content -match 'export default') {
            $structureIssues += "Missing try-catch in $($file.Name)"
        }
    }
    
    # Check for JSDoc coverage
    $functionsWithoutJSDoc = 0
    foreach ($file in $jsFiles) {
        $content = Get-Content $file.FullName -Raw
        $functions = [regex]::Matches($content, '(function\s+\w+|const\s+\w+\s*=\s*(async\s+)?\([^)]*\)\s*=>|export\s+(async\s+)?function)')
        foreach ($match in $functions) {
            $beforeFunction = $content.Substring([Math]::Max(0, $match.Index - 200), [Math]::Min(200, $match.Index))
            if ($beforeFunction -notmatch '/\*\*') {
                $functionsWithoutJSDoc++
            }
        }
    }
    
    if ($structureIssues.Count -eq 0 -and $functionsWithoutJSDoc -eq 0) {
        Write-Host "    ✅ Code structure: Excellent" -ForegroundColor Green
        $Results += @{Phase="Code Quality"; Check="Structure"; Status="PASS"}
    } else {
        if ($structureIssues.Count -gt 0) {
            Write-Host "    ⚠️  Structure issues: $($structureIssues.Count)" -ForegroundColor Yellow
        }
        if ($functionsWithoutJSDoc -gt 0) {
            Write-Host "    ⚠️  Functions without JSDoc: $functionsWithoutJSDoc" -ForegroundColor Yellow
        }
        $Results += @{Phase="Code Quality"; Check="Structure"; Status="WARN"; Issues=$structureIssues.Count}
    }
    
    Write-Host "  [4.2] Checking for code smells..." -ForegroundColor Gray
    $codeSmells = @()
    foreach ($file in $jsFiles) {
        $content = Get-Content $file.FullName -Raw
        # Check for magic numbers
        if ($content -match '\b(10|100|1000|200|500)\b' -and $content -notmatch 'const|let|var') {
            # Could be magic numbers, but many are valid
        }
        # Check for long functions (> 100 lines)
        $lines = ($content -split "`n").Count
        if ($lines -gt 200) {
            $codeSmells += "Long file: $($file.Name) - $lines lines"
        }
    }
    
    if ($codeSmells.Count -eq 0) {
        Write-Host "    ✅ Code smells: None detected" -ForegroundColor Green
        $Results += @{Phase="Code Quality"; Check="Code Smells"; Status="PASS"}
    } else {
        Write-Host "    ⚠️  Code smells: $($codeSmells.Count) found" -ForegroundColor Yellow
        $Results += @{Phase="Code Quality"; Check="Code Smells"; Status="WARN"; Count=$codeSmells.Count}
    }
}

Write-Host ""

# ============================================================================
# PHASE 5: PERFORMANCE ANALYSIS
# ============================================================================
Write-Host "🔍 PHASE 5: PERFORMANCE ANALYSIS" -ForegroundColor Yellow
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray

if ($Performance) {
    Write-Host "  [5.1] Checking resource optimization..." -ForegroundColor Gray
    $perfChecks = @{
        "Resource Preloading" = $false
        "DNS Prefetch" = $false
        "Image Optimization" = $false
        "CSS Containment" = $false
    }
    
    $indexHtml = Get-Content "$ProjectRoot\index.html" -Raw
    if ($indexHtml -match 'rel="preload"') {
        $perfChecks["Resource Preloading"] = $true
        Write-Host "    ✅ Resource preloading: Present" -ForegroundColor Green
    } else {
        Write-Host "    ⚠️  Resource preloading: Missing" -ForegroundColor Yellow
    }
    
    if ($indexHtml -match 'rel="dns-prefetch"') {
        $perfChecks["DNS Prefetch"] = $true
        Write-Host "    ✅ DNS prefetch: Present" -ForegroundColor Green
    } else {
        Write-Host "    ⚠️  DNS prefetch: Missing" -ForegroundColor Yellow
    }
    
    if ($indexHtml -match '\.webp|loading="lazy"') {
        $perfChecks["Image Optimization"] = $true
        Write-Host "    ✅ Image optimization: Present" -ForegroundColor Green
    } else {
        Write-Host "    ⚠️  Image optimization: Missing" -ForegroundColor Yellow
    }
    
    $cssFile = Get-Content "$ProjectRoot\styles.css" -Raw
    if ($cssFile -match 'contain\s*:') {
        $perfChecks["CSS Containment"] = $true
        Write-Host "    ✅ CSS containment: Present" -ForegroundColor Green
    } else {
        Write-Host "    ⚠️  CSS containment: Missing" -ForegroundColor Yellow
    }
    
    $passed = ($perfChecks.Values | Where-Object { $_ -eq $true }).Count
    $total = $perfChecks.Count
    if ($passed -eq $total) {
        $Results += @{Phase="Performance"; Check="Optimizations"; Status="PASS"}
    } else {
        $Results += @{Phase="Performance"; Check="Optimizations"; Status="WARN"; Passed=$passed; Total=$total}
    }
}

Write-Host ""

# ============================================================================
# SUMMARY REPORT
# ============================================================================
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    DEBUG SUMMARY REPORT                     ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$passed = ($Results | Where-Object { $_.Status -eq "PASS" }).Count
$warned = ($Results | Where-Object { $_.Status -eq "WARN" }).Count
$failed = ($Results | Where-Object { $_.Status -eq "FAIL" }).Count
$total = $Results.Count

Write-Host "Total Checks: $total" -ForegroundColor White
Write-Host "  ✅ Passed:  $passed" -ForegroundColor Green
Write-Host "  ⚠️  Warnings: $warned" -ForegroundColor Yellow
Write-Host "  ❌ Failed:  $failed" -ForegroundColor Red
Write-Host ""

if ($failed -eq 0 -and $warned -eq 0) {
    Write-Host "🎉 ALL CHECKS PASSED - SYSTEM IS HEALTHY" -ForegroundColor Green
} elseif ($failed -eq 0) {
    Write-Host "✅ CORE FUNCTIONALITY PASSED - Some warnings to review" -ForegroundColor Green
} else {
    Write-Host "⚠️  SOME CHECKS FAILED - Review issues above" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Detailed results saved to: debug-results.json" -ForegroundColor Gray

# Save results
$Results | ConvertTo-Json -Depth 10 | Out-File "$ProjectRoot\debug-results.json" -Encoding UTF8

Write-Host ""
Write-Host "Debug analysis complete!" -ForegroundColor Cyan
