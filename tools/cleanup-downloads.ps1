# Cleanup Downloads Folder - Project-Related Files
# Finds and archives project-related files in Downloads folder

param(
    [string]$DownloadsPath = "$env:USERPROFILE\Downloads",
    [string]$ProjectRoot = $PSScriptRoot + "\..",
    [switch]$DryRun = $false
)

Write-Host "=== Downloads Cleanup ===" -ForegroundColor Cyan
Write-Host "Downloads: $DownloadsPath" -ForegroundColor Gray
Write-Host "Project: $ProjectRoot" -ForegroundColor Gray
Write-Host "Dry Run: $DryRun" -ForegroundColor $(if ($DryRun) { "Yellow" } else { "Green" })
Write-Host ""

# Search patterns
$patterns = @(
    "*cheeks*",
    "*cheek*",
    "*cheeks-bar-and-grill*",
    "*cheeks-vercel*"
)

# Target directory
$targetDir = "$ProjectRoot\docs\archive\desktop-files\downloads"

if (-not (Test-Path $targetDir)) {
    if (-not $DryRun) {
        New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
        Write-Host "Created: $targetDir" -ForegroundColor Green
    }
}

$filesFound = @()

foreach ($pattern in $patterns) {
    $files = Get-ChildItem -Path $DownloadsPath -Filter $pattern -File -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        # Skip the active project folder
        if ($file.FullName -notlike "*cheeks-vercel-fixed*" -or $file.Extension -ne "") {
            if ($filesFound -notcontains $file.FullName) {
                $filesFound += $file.FullName
            }
        }
    }
}

if ($filesFound.Count -eq 0) {
    Write-Host "No project-related files found in Downloads (excluding active project folder)." -ForegroundColor Green
    exit 0
}

Write-Host "Found $($filesFound.Count) file(s) matching project patterns:" -ForegroundColor Cyan
Write-Host ""

$filesProcessed = 0
$filesArchived = 0

foreach ($filePath in $filesFound) {
    $file = Get-Item $filePath
    Write-Host "Found: $($file.Name)" -ForegroundColor Yellow
    
    $targetPath = Join-Path $targetDir $file.Name
    
    if (Test-Path $targetPath) {
        Write-Host "  → Already archived: $targetPath" -ForegroundColor Gray
        $filesProcessed++
    } else {
        if ($DryRun) {
            Write-Host "  → Would archive to: $targetPath" -ForegroundColor Gray
            $filesProcessed++
        } else {
            Copy-Item $file.FullName -Destination $targetPath -Force
            Write-Host "  → Archived to: $targetPath" -ForegroundColor Green
            $filesArchived++
        }
    }
    Write-Host ""
}

Write-Host "=== Summary ===" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "Files that would be processed: $filesProcessed" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Run without -DryRun to execute cleanup." -ForegroundColor Yellow
} else {
    Write-Host "Files processed: $filesProcessed" -ForegroundColor Green
    Write-Host "Files archived: $filesArchived" -ForegroundColor Green
    Write-Host ""
    Write-Host "Note: Original files remain in Downloads." -ForegroundColor Gray
    Write-Host "Review archived files, then delete Downloads originals manually if desired." -ForegroundColor Gray
}
