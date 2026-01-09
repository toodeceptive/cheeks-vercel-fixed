# Find Sensitive Files - API Keys, Passwords, Secrets
# Searches for files that might contain sensitive information

param(
    [string]$ProjectRoot = $PSScriptRoot + "\.."
)

Write-Host "=== Sensitive Files Search ===" -ForegroundColor Cyan
Write-Host "Searching for files that might contain sensitive information..." -ForegroundColor Yellow
Write-Host ""

# Search patterns for sensitive files
$sensitivePatterns = @(
    "*API*Key*",
    "*api*key*",
    "*password*",
    "*secret*",
    "*token*",
    "*credential*",
    "*.env*",
    "*config*"
)

# Search locations
$searchLocations = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Documents"
)

$foundFiles = @()

foreach ($location in $searchLocations) {
    if (-not (Test-Path $location)) {
        continue
    }
    
    Write-Host "Searching: $location" -ForegroundColor Yellow
    
    foreach ($pattern in $sensitivePatterns) {
        try {
            $files = Get-ChildItem -Path $location -Filter $pattern -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
                $_.FullName -notlike "*cheeks-vercel-fixed\*"
            }
            
            foreach ($file in $files) {
                if ($foundFiles -notcontains $file.FullName) {
                    $foundFiles += $file.FullName
                }
            }
        } catch {
            # Silently continue
        }
    }
}

if ($foundFiles.Count -eq 0) {
    Write-Host "No sensitive files found outside project folder." -ForegroundColor Green
    exit 0
}

Write-Host ""
Write-Host "=== Sensitive Files Found ===" -ForegroundColor Cyan
Write-Host "Total: $($foundFiles.Count) file(s)" -ForegroundColor Yellow
Write-Host ""

foreach ($filePath in $foundFiles) {
    $file = Get-Item $filePath
    Write-Host "⚠️  $($file.Name)" -ForegroundColor Red
    Write-Host "   Location: $($file.DirectoryName)" -ForegroundColor Gray
    Write-Host "   Size: $([math]::Round($file.Length / 1KB, 2)) KB" -ForegroundColor Gray
    Write-Host ""
}

Write-Host "=== Recommendations ===" -ForegroundColor Cyan
Write-Host "1. Review each file for sensitive content" -ForegroundColor Yellow
Write-Host "2. If containing secrets, move to secure location" -ForegroundColor Yellow
Write-Host "3. Delete from desktop/downloads if archived" -ForegroundColor Yellow
Write-Host "4. Never commit sensitive files to Git" -ForegroundColor Yellow
Write-Host "5. Use environment variables for secrets" -ForegroundColor Yellow
