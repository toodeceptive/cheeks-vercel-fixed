# Test New Improvements
param(
    [string]$BaseUrl = "https://cheeks-bar-and-grill.vercel.app"
)

Write-Host "=== Testing New Improvements ===" -ForegroundColor Cyan
Write-Host ""

# Test 1: Server-side phone validation
Write-Host "[TEST] Server-side phone validation" -ForegroundColor Yellow
$futureDate = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
$invalidPhonePayload = @{
    name = "Test"
    phone = "invalid-phone-format"
    email = "test@test.com"
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $invalidPhonePayload -ContentType "application/json" -ErrorAction Stop
    Write-Host "  WARN: Should have rejected invalid phone" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $body = $reader.ReadToEnd() | ConvertFrom-Json
        if ($body.error -match "phone") {
            Write-Host "  PASS: Server-side phone validation working" -ForegroundColor Green
        } else {
            Write-Host "  WARN: Rejected but wrong error message" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  FAIL: Unexpected error" -ForegroundColor Red
    }
}

# Test 2: Rate limiting (make 11 rapid requests)
Write-Host "[TEST] Rate limiting" -ForegroundColor Yellow
$validPayload = @{
    name = "Rate Limit Test"
    phone = "(715) 555-1234"
    email = "ratelimit@test.com"
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Rate limit test"
} | ConvertTo-Json

$rateLimitHit = $false
for ($i = 1; $i -le 11; $i++) {
    try {
        $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $validPayload -ContentType "application/json" -ErrorAction Stop
        Write-Host "  Request $i : OK" -ForegroundColor Gray
    } catch {
        if ($_.Exception.Response.StatusCode -eq 429) {
            Write-Host "  PASS: Rate limiting working (429 on request $i)" -ForegroundColor Green
            $rateLimitHit = $true
            break
        }
    }
    Start-Sleep -Milliseconds 100
}
if (-not $rateLimitHit) {
    Write-Host "  WARN: Rate limit not triggered (may need more requests or time)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=== Testing Complete ===" -ForegroundColor Cyan
