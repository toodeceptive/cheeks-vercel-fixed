# Cleanup Desktop Folder - Cheek's Bar & Grill
# Cleans up the desktop folder containing project images

param(
    [string]$DesktopFolder = "$env:USERPROFILE\Desktop\Cheek's Bar & Grill",
    [string]$ProjectRoot = $PSScriptRoot + "\..",
    [switch]$DryRun = $false
)

Write-Host "=== Desktop Folder Cleanup ===" -ForegroundColor Cyan
Write-Host "Desktop Folder: $DesktopFolder" -ForegroundColor Gray
Write-Host "Project Root: $ProjectRoot" -ForegroundColor Gray
Write-Host "Dry Run: $DryRun" -ForegroundColor $(if ($DryRun) { "Yellow" } else { "Green" })
Write-Host ""

if (-not (Test-Path $DesktopFolder)) {
    Write-Host "Desktop folder not found: $DesktopFolder" -ForegroundColor Yellow
    Write-Host "Nothing to clean up." -ForegroundColor Green
    exit 0
}

# Target directories
$targetDirs = @{
    "images" = "$ProjectRoot\docs\archive\desktop-files\images"
    "assets" = "$ProjectRoot\assets\images"
}

# Create target directories
foreach ($dir in $targetDirs.Values) {
    if (-not (Test-Path $dir)) {
        if (-not $DryRun) {
            New-Item -ItemType Directory -Force -Path $dir | Out-Null
            Write-Host "Created: $dir" -ForegroundColor Green
        } else {
            Write-Host "Would create: $dir" -ForegroundColor Gray
        }
    }
}

# Files to process
$files = Get-ChildItem -Path $DesktopFolder -File

if ($files.Count -eq 0) {
    Write-Host "No files found in desktop folder." -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($files.Count) file(s) in desktop folder:" -ForegroundColor Cyan
Write-Host ""

$filesProcessed = 0
$filesArchived = 0
$filesSkipped = 0

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    # Determine target location
    $target = if ($file.Extension -match "\.(jpg|jpeg|png|gif|webp|svg)") {
        # Images: Check if needed for website (move to assets) or archive
        $targetDirs["assets"]
    } else {
        # Other files: Archive
        $targetDirs["images"]
    }
    
    $targetPath = Join-Path $target $file.Name
    
    if (Test-Path $targetPath) {
        Write-Host "  → Skipped (already exists): $targetPath" -ForegroundColor Gray
        $filesSkipped++
    } else {
        if ($DryRun) {
            Write-Host "  → Would copy to: $targetPath" -ForegroundColor Gray
            $filesProcessed++
        } else {
            Copy-Item $file.FullName -Destination $targetPath -Force
            Write-Host "  → Copied to: $targetPath" -ForegroundColor Green
            $filesArchived++
        }
    }
    Write-Host ""
}

Write-Host "=== Summary ===" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "Files that would be processed: $filesProcessed" -ForegroundColor Yellow
    Write-Host "Files that would be skipped: $filesSkipped" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Run without -DryRun to execute cleanup." -ForegroundColor Yellow
} else {
    Write-Host "Files processed: $filesProcessed" -ForegroundColor Green
    Write-Host "Files archived: $filesArchived" -ForegroundColor Green
    Write-Host "Files skipped: $filesSkipped" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Note: Original files remain in desktop folder." -ForegroundColor Gray
    Write-Host "Review archived files, then delete desktop originals manually if desired." -ForegroundColor Gray
}
