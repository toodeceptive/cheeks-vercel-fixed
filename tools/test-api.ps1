# Test API Endpoints
# Comprehensive testing of Cheeks Bar & Grill API

param(
    [string]$BaseUrl = "https://cheeks-bar-and-grill.vercel.app",
    [string]$TestEmail = "test@example.com",
    [string]$TestPhone = "(715) 555-1234"
)

Write-Host "=== Cheeks Bar & Grill API Testing ===" -ForegroundColor Cyan
Write-Host "Base URL: $BaseUrl" -ForegroundColor Gray
Write-Host ""

# Test 1: Health Check
Write-Host "[TEST 1] Health Check" -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "$BaseUrl/api/health" -Method GET
    if ($health.ok) {
        Write-Host "  ✅ Health check passed" -ForegroundColor Green
        Write-Host "    Service: $($health.service)" -ForegroundColor Gray
        Write-Host "    Timestamp: $($health.ts)" -ForegroundColor Gray
    } else {
        Write-Host "  ❌ Health check failed" -ForegroundColor Red
    }
} catch {
    Write-Host "  ❌ Health check error: $_" -ForegroundColor Red
}
Write-Host ""

# Test 2: Sample Inquiry
Write-Host "[TEST 2] Sample Inquiry Endpoint" -ForegroundColor Yellow
try {
    $sample = Invoke-RestMethod -Uri "$BaseUrl/api/sample-inquiry" -Method GET
    if ($sample.ok) {
        Write-Host "  ✅ Sample inquiry generated" -ForegroundColor Green
        Write-Host "    Event Type: $($sample.sample.eventType)" -ForegroundColor Gray
        Write-Host "    Date: $($sample.sample.eventDate)" -ForegroundColor Gray
    } else {
        Write-Host "  ❌ Sample inquiry failed" -ForegroundColor Red
    }
} catch {
    Write-Host "  ❌ Sample inquiry error: $_" -ForegroundColor Red
}
Write-Host ""

# Test 3: Valid Form Submission
Write-Host "[TEST 3] Valid Form Submission" -ForegroundColor Yellow
$futureDate = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
$validPayload = @{
    name = "Test User"
    phone = $TestPhone
    email = $TestEmail
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Test submission from automated testing script"
    src = "test-script"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $validPayload -ContentType "application/json; charset=utf-8"
    if ($response.ok) {
        Write-Host "  ✅ Form submission successful" -ForegroundColor Green
        Write-Host "    Reference ID: $($response.id)" -ForegroundColor Gray
        Write-Host "    Status: $($response.status)" -ForegroundColor Gray
        Write-Host "    Owner Email: $($response.ownerEmail)" -ForegroundColor Gray
        $global:testInquiryId = $response.id
    } else {
        Write-Host "  ❌ Form submission failed" -ForegroundColor Red
    }
} catch {
    Write-Host "  ❌ Form submission error: $_" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "    Response: $responseBody" -ForegroundColor Gray
    }
}
Write-Host ""

# Test 4: Invalid Phone Number
Write-Host "[TEST 4] Invalid Phone Number Validation" -ForegroundColor Yellow
$invalidPhonePayload = @{
    name = "Test User"
    phone = "invalid-phone"
    email = $TestEmail
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Test"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $invalidPhonePayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
    Write-Host "  ⚠️  Should have rejected invalid phone" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "  ✅ Correctly rejected invalid phone" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Unexpected error: $_" -ForegroundColor Red
    }
}
Write-Host ""

# Test 5: Past Date Validation
Write-Host "[TEST 5] Past Date Validation" -ForegroundColor Yellow
$pastDate = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")
$pastDatePayload = @{
    name = "Test User"
    phone = $TestPhone
    email = $TestEmail
    eventType = "Birthday"
    eventDate = $pastDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Test"
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $pastDatePayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
    Write-Host "  ⚠️  Should have rejected past date" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "  ✅ Correctly rejected past date" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Unexpected error: $_" -ForegroundColor Red
    }
}
Write-Host ""

# Test 6: Request Size Limit
Write-Host "[TEST 6] Request Size Limit (10KB)" -ForegroundColor Yellow
$largeNotes = "x" * 11000  # Create payload > 10KB
$largePayload = @{
    name = "Test User"
    phone = $TestPhone
    email = $TestEmail
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = $largeNotes
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $largePayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
    Write-Host "  ⚠️  Should have rejected large payload" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode -eq 413) {
        Write-Host "  ✅ Correctly rejected large payload (413 Request Too Large)" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Unexpected error: $_" -ForegroundColor Red
    }
}
Write-Host ""

# Test 7: Honeypot Protection
Write-Host "[TEST 7] Honeypot Protection" -ForegroundColor Yellow
$honeypotPayload = @{
    name = "Test User"
    phone = $TestPhone
    email = $TestEmail
    eventType = "Birthday"
    eventDate = $futureDate
    eventTime = "18:00"
    guests = 20
    package = "A"
    notes = "Test"
    company = "bot"  # Honeypot field
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $honeypotPayload -ContentType "application/json; charset=utf-8"
    if ($response.id -eq "hp") {
        Write-Host "  ✅ Honeypot correctly detected bot" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️  Honeypot response unexpected" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ❌ Honeypot test error: $_" -ForegroundColor Red
}
Write-Host ""

# Test 8: Missing Required Fields
Write-Host "[TEST 8] Missing Required Fields" -ForegroundColor Yellow
$incompletePayload = @{
    name = "Test User"
    # Missing phone, email, etc.
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$BaseUrl/api/inquiry" -Method POST -Body $incompletePayload -ContentType "application/json; charset=utf-8" -ErrorAction Stop
    Write-Host "  ⚠️  Should have rejected incomplete payload" -ForegroundColor Yellow
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Write-Host "  ✅ Correctly rejected incomplete payload" -ForegroundColor Green
    } else {
        Write-Host "  ❌ Unexpected error: $_" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "=== Testing Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Note: For email/phone notification testing, configure:" -ForegroundColor Gray
Write-Host "  - RESEND_API_KEY in Vercel environment variables" -ForegroundColor Gray
Write-Host "  - OWNER_NOTIFY_EMAILS with your email address" -ForegroundColor Gray
Write-Host "  - FROM_EMAIL (must be verified in Resend)" -ForegroundColor Gray
Write-Host ""
