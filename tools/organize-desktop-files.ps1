# Desktop Files Organization Script
# Organizes Cheeks Bar & Grill project files from desktop into project structure

param(
    [string]$DesktopPath = "$env:USERPROFILE\Desktop",
    [string]$ProjectRoot = $PSScriptRoot + "\.."
)

Write-Host "=== Desktop Files Organization ===" -ForegroundColor Cyan
Write-Host "Desktop: $DesktopPath" -ForegroundColor Gray
Write-Host "Project: $ProjectRoot" -ForegroundColor Gray
Write-Host ""

# Create target directories
$targetDirs = @{
    "pdfs" = "$ProjectRoot\docs\presentations\desktop-archive\pdfs"
    "word" = "$ProjectRoot\docs\presentations\desktop-archive\word-docs"
    "archives" = "$ProjectRoot\docs\archive\desktop-files\zip-archives"
    "vercel" = "$ProjectRoot\docs\deployment\desktop-archive\vercel-screenshots"
    "data" = "$ProjectRoot\docs\deployment\desktop-archive\data"
}

foreach ($dir in $targetDirs.Values) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        Write-Host "Created: $dir" -ForegroundColor Green
    }
}

# Find and organize files
$filesMoved = 0
$filesSkipped = 0

# PDF files
Get-ChildItem -Path $DesktopPath -Filter "*cheeks*" -File | Where-Object { $_.Extension -eq ".pdf" } | ForEach-Object {
    $target = $targetDirs["pdfs"] + "\" + $_.Name
    if (-not (Test-Path $target)) {
        Copy-Item $_.FullName -Destination $target -Force
        Write-Host "Moved PDF: $($_.Name)" -ForegroundColor Yellow
        $filesMoved++
    } else {
        Write-Host "Skipped (exists): $($_.Name)" -ForegroundColor Gray
        $filesSkipped++
    }
}

# Word documents
Get-ChildItem -Path $DesktopPath -Filter "*cheeks*" -File | Where-Object { $_.Extension -match "\.(docx?|doc)" } | ForEach-Object {
    $target = $targetDirs["word"] + "\" + $_.Name
    if (-not (Test-Path $target)) {
        Copy-Item $_.FullName -Destination $target -Force
        Write-Host "Moved Word: $($_.Name)" -ForegroundColor Yellow
        $filesMoved++
    } else {
        Write-Host "Skipped (exists): $($_.Name)" -ForegroundColor Gray
        $filesSkipped++
    }
}

# ZIP archives
Get-ChildItem -Path $DesktopPath -Filter "*cheeks*" -File | Where-Object { $_.Extension -eq ".zip" } | ForEach-Object {
    $target = $targetDirs["archives"] + "\" + $_.Name
    if (-not (Test-Path $target)) {
        Copy-Item $_.FullName -Destination $target -Force
        Write-Host "Moved ZIP: $($_.Name)" -ForegroundColor Yellow
        $filesMoved++
    } else {
        Write-Host "Skipped (exists): $($_.Name)" -ForegroundColor Gray
        $filesSkipped++
    }
}

# CSV/Data files
Get-ChildItem -Path $DesktopPath -Filter "*cheeks*" -File | Where-Object { $_.Extension -eq ".csv" } | ForEach-Object {
    $target = $targetDirs["data"] + "\" + $_.Name
    if (-not (Test-Path $target)) {
        Copy-Item $_.FullName -Destination $target -Force
        Write-Host "Moved CSV: $($_.Name)" -ForegroundColor Yellow
        $filesMoved++
    } else {
        Write-Host "Skipped (exists): $($_.Name)" -ForegroundColor Gray
        $filesSkipped++
    }
}

Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Files moved: $filesMoved" -ForegroundColor Green
Write-Host "Files skipped: $filesSkipped" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: Original files remain on desktop. Review and delete manually if desired." -ForegroundColor Gray
