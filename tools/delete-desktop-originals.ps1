# Delete Desktop Originals - After Archive Verification
# SAFELY deletes desktop files that have been archived

param(
    [string]$DesktopPath = "$env:USERPROFILE\Desktop",
    [string]$ProjectRoot = $PSScriptRoot + "\..",
    [switch]$DryRun = $true,
    [switch]$Force
)

Write-Host "=== Delete Desktop Originals ===" -ForegroundColor Cyan
Write-Host "WARNING: This will DELETE files from your desktop!" -ForegroundColor Red
Write-Host ""

if (-not $Force) {
    Write-Host "This script requires -Force flag to actually delete files." -ForegroundColor Yellow
    Write-Host "Run with -DryRun first to see what would be deleted." -ForegroundColor Yellow
    Write-Host ""
}

# Archive locations to verify against
$archiveLocations = @(
    "$ProjectRoot\docs\archive\desktop-files\comprehensive-cleanup",
    "$ProjectRoot\docs\archive\desktop-files\misc",
    "$ProjectRoot\docs\archive\desktop-files\downloads",
    "$ProjectRoot\assets\images"
)

# Get all archived files
$archivedFiles = @()
foreach ($archiveLocation in $archiveLocations) {
    if (Test-Path $archiveLocation) {
        $files = Get-ChildItem -Path $archiveLocation -Recurse -File
        foreach ($file in $files) {
            $archivedFiles += $file.Name
        }
    }
}

Write-Host "Found $($archivedFiles.Count) files in archive" -ForegroundColor Green
Write-Host ""

# Search patterns
$patterns = @(
    "*cheeks*",
    "*cheek*",
    "*caterflow*"
)

# Find desktop files
$desktopFiles = @()
foreach ($pattern in $patterns) {
    $files = Get-ChildItem -Path $DesktopPath -Filter $pattern -Recurse -File -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        # Exclude project folder
        if ($file.FullName -notlike "*cheeks-vercel-fixed\*") {
            if ($desktopFiles -notcontains $file.FullName) {
                $desktopFiles += $file.FullName
            }
        }
    }
}

Write-Host "Found $($desktopFiles.Count) project-related files on desktop" -ForegroundColor Yellow
Write-Host ""

# Check which files are archived
$filesToDelete = @()
$filesToKeep = @()

foreach ($filePath in $desktopFiles) {
    $file = Get-Item $filePath
    
    # Skip sensitive files - require manual review
    if ($file.Name -match "API.*Key|password|secret|token|credential" -and $file.Name -notlike "*.pdf") {
        Write-Host "⚠️  SKIPPING (sensitive): $($file.Name)" -ForegroundColor Red
        Write-Host "   Review manually before deleting" -ForegroundColor Yellow
        $filesToKeep += $file
        continue
    }
    
    if ($archivedFiles -contains $file.Name) {
        $filesToDelete += $file
    } else {
        Write-Host "⚠️  NOT ARCHIVED: $($file.Name)" -ForegroundColor Yellow
        Write-Host "   Will NOT delete (not in archive)" -ForegroundColor Gray
        $filesToKeep += $file
    }
}

Write-Host ""
Write-Host "=== Files to Delete ===" -ForegroundColor Cyan
Write-Host "Total: $($filesToDelete.Count) file(s)" -ForegroundColor Yellow
Write-Host ""

if ($filesToDelete.Count -eq 0) {
    Write-Host "No files to delete (all either not archived or sensitive)." -ForegroundColor Green
    exit 0
}

# Show files that would be deleted
foreach ($file in $filesToDelete) {
    Write-Host "  $($file.Name)" -ForegroundColor Yellow
    Write-Host "    Location: $($file.DirectoryName)" -ForegroundColor Gray
    Write-Host "    Archived: Yes" -ForegroundColor Green
    Write-Host ""
}

# Delete files
if ($DryRun) {
    Write-Host "=== Dry Run Complete ===" -ForegroundColor Cyan
    Write-Host "No files were deleted." -ForegroundColor Yellow
    Write-Host "Run with -DryRun:$false -Force to actually delete files." -ForegroundColor Yellow
} elseif ($Force) {
    Write-Host "=== Deleting Files ===" -ForegroundColor Cyan
    $deleted = 0
    $errors = 0
    
    foreach ($file in $filesToDelete) {
        try {
            Remove-Item $file.FullName -Force
            Write-Host "Deleted: $($file.Name)" -ForegroundColor Green
            $deleted++
        } catch {
            Write-Host "Error deleting: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
            $errors++
        }
    }
    
    Write-Host ""
    Write-Host "=== Summary ===" -ForegroundColor Cyan
    Write-Host "Files deleted: $deleted" -ForegroundColor Green
    Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -gt 0) { "Red" } else { "Gray" })
} else {
    Write-Host "=== Action Required ===" -ForegroundColor Cyan
    Write-Host "Add -Force flag to actually delete files." -ForegroundColor Yellow
    Write-Host "Example: .\delete-desktop-originals.ps1 -DryRun:$false -Force" -ForegroundColor Gray
}
