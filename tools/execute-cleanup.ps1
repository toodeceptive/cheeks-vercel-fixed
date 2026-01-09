# Execute Complete Cleanup
# Reviews archives and safely deletes desktop originals

param(
    [switch]$DryRun = $true,
    [switch]$Force
)

Write-Host "=== Desktop Cleanup Execution ===" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "DRY RUN MODE - No files will be deleted" -ForegroundColor Yellow
    Write-Host ""
}

# Verify archives exist
$archivePath = Join-Path $PSScriptRoot "..\docs\archive\desktop-files"
if (-not (Test-Path $archivePath)) {
    Write-Host "ERROR: Archive path not found: $archivePath" -ForegroundColor Red
    exit 1
}

Write-Host "Archive location: $archivePath" -ForegroundColor Green
$archivedFiles = Get-ChildItem $archivePath -Recurse -File
Write-Host "Archived files: $($archivedFiles.Count)" -ForegroundColor Green
Write-Host ""

# Desktop files to check
$desktop = $env:USERPROFILE + "\Desktop"
$desktopFiles = @()

# Find all project-related files on desktop
$patterns = @("*cheeks*", "*caterflow*")
foreach ($pattern in $patterns) {
    $files = Get-ChildItem $desktop -Filter $pattern -File -ErrorAction SilentlyContinue
    $desktopFiles += $files
    
    $folderFiles = Get-ChildItem "$desktop\Cheek's Bar & Grill" -Filter $pattern -File -ErrorAction SilentlyContinue
    $desktopFiles += $folderFiles
}

Write-Host "=== Desktop Files Found ===" -ForegroundColor Cyan
Write-Host "Total: $($desktopFiles.Count) files" -ForegroundColor Yellow
Write-Host ""

# Check for sensitive files
$sensitiveFiles = @()
foreach ($file in $desktopFiles) {
    if ($file.Name -like "*API*Key*" -or $file.Name -like "*Cloudflare*") {
        $sensitiveFiles += $file
    }
}

if ($sensitiveFiles.Count -gt 0) {
    Write-Host "⚠️  SENSITIVE FILES FOUND - REVIEW BEFORE DELETION" -ForegroundColor Red
    foreach ($file in $sensitiveFiles) {
        Write-Host "  - $($file.FullName)" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "ACTION REQUIRED: Review these files before deletion!" -ForegroundColor Red
    Write-Host ""
}

# List all files
$fileNum = 1
foreach ($file in $desktopFiles) {
    $archived = $false
    foreach ($archivedFile in $archivedFiles) {
        if ($archivedFile.Name -eq $file.Name) {
            $archived = $true
            break
        }
    }
    
    $status = if ($archived) { "✅ ARCHIVED" } else { "⚠️  NOT ARCHIVED" }
    $color = if ($archived) { "Green" } else { "Red" }
    
    Write-Host "$fileNum. $($file.Name)" -ForegroundColor $color
    Write-Host "   Location: $($file.DirectoryName)" -ForegroundColor Gray
    Write-Host "   Size: $([math]::Round($file.Length / 1KB, 2)) KB" -ForegroundColor Gray
    Write-Host "   Status: $status" -ForegroundColor $color
    Write-Host ""
    
    $fileNum++
}

# Summary
$archivedCount = ($desktopFiles | Where-Object {
    $name = $_.Name
    $archivedFiles | Where-Object { $_.Name -eq $name }
}).Count

$notArchivedCount = $desktopFiles.Count - $archivedCount

Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Total files: $($desktopFiles.Count)" -ForegroundColor Yellow
Write-Host "Archived: $archivedCount" -ForegroundColor Green
Write-Host "Not archived: $notArchivedCount" -ForegroundColor $(if ($notArchivedCount -gt 0) { "Red" } else { "Green" })
Write-Host "Sensitive files: $($sensitiveFiles.Count)" -ForegroundColor $(if ($sensitiveFiles.Count -gt 0) { "Red" } else { "Green" })
Write-Host ""

if (-not $DryRun -and $Force) {
    if ($notArchivedCount -gt 0) {
        Write-Host "⚠️  WARNING: Some files are not archived. Deletion cancelled." -ForegroundColor Red
        exit 1
    }
    
    if ($sensitiveFiles.Count -gt 0) {
        Write-Host "⚠️  WARNING: Sensitive files found. Please review before deletion." -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Deleting files..." -ForegroundColor Yellow
    $deleted = 0
    foreach ($file in $desktopFiles) {
        try {
            Remove-Item $file.FullName -Force
            Write-Host "  ✅ Deleted: $($file.Name)" -ForegroundColor Green
            $deleted++
        } catch {
            Write-Host "  ❌ Error deleting $($file.Name): $_" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "Deleted: $deleted / $($desktopFiles.Count) files" -ForegroundColor Green
    
    # Delete folder if empty
    $folderPath = "$desktop\Cheek's Bar & Grill"
    if (Test-Path $folderPath) {
        $folderFiles = Get-ChildItem $folderPath -File -ErrorAction SilentlyContinue
        if ($folderFiles.Count -eq 0) {
            Remove-Item $folderPath -Force -ErrorAction SilentlyContinue
            Write-Host "  ✅ Deleted empty folder: Cheek's Bar & Grill" -ForegroundColor Green
        }
    }
} else {
    Write-Host "DRY RUN: No files deleted. Use -DryRun:`$false -Force to delete." -ForegroundColor Yellow
}
