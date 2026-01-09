# Comprehensive File Search - Find ALL Project-Related Files
# Searches multiple locations for any files related to Cheeks Bar & Grill project

param(
    [string]$ProjectRoot = $PSScriptRoot + "\..",
    [switch]$DryRun = $false
)

Write-Host "=== Comprehensive Project File Search ===" -ForegroundColor Cyan
Write-Host "Searching for ALL project-related files..." -ForegroundColor Yellow
Write-Host ""

# Search patterns
$patterns = @(
    "*cheeks*",
    "*cheek*",
    "*cheeks-bar*",
    "*cheeks-vercel*",
    "*cheeks_bar*",
    "*caterflow*"
)

# Search locations
$searchLocations = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Pictures",
    "$env:USERPROFILE\OneDrive",
    "$env:TEMP"
)

# Target archive directory
$archiveRoot = "$ProjectRoot\docs\archive\desktop-files\comprehensive-cleanup"

if (-not (Test-Path $archiveRoot)) {
    if (-not $DryRun) {
        New-Item -ItemType Directory -Force -Path $archiveRoot | Out-Null
        Write-Host "Created archive directory: $archiveRoot" -ForegroundColor Green
    }
}

$allFiles = @()
$filesByLocation = @{}

Write-Host "Searching locations..." -ForegroundColor Cyan
Write-Host ""

foreach ($location in $searchLocations) {
    if (-not (Test-Path $location)) {
        Write-Host "Skipping (not found): $location" -ForegroundColor Gray
        continue
    }
    
    Write-Host "Searching: $location" -ForegroundColor Yellow
    
    $locationFiles = @()
    
    foreach ($pattern in $patterns) {
        try {
            $files = Get-ChildItem -Path $location -Filter $pattern -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
                # Exclude the project folder itself
                $_.FullName -notlike "*cheeks-vercel-fixed\*" -or $_.FullName -like "*cheeks-vercel-fixed\docs\archive\*"
            }
            
            foreach ($file in $files) {
                if ($allFiles -notcontains $file.FullName) {
                    $allFiles += $file.FullName
                    $locationFiles += $file
                }
            }
        } catch {
            # Silently continue if access denied
        }
    }
    
    if ($locationFiles.Count -gt 0) {
        $filesByLocation[$location] = $locationFiles
        Write-Host "  Found: $($locationFiles.Count) file(s)" -ForegroundColor Green
    } else {
        Write-Host "  Found: 0 files" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "=== Search Results ===" -ForegroundColor Cyan
Write-Host "Total files found: $($allFiles.Count)" -ForegroundColor Yellow
Write-Host ""

if ($allFiles.Count -eq 0) {
    Write-Host "No project-related files found outside the project folder." -ForegroundColor Green
    exit 0
}

# Group by file type
$byType = @{
    "PDF" = @()
    "ZIP" = @()
    "Images" = @()
    "Documents" = @()
    "Data" = @()
    "Other" = @()
}

foreach ($filePath in $allFiles) {
    $file = Get-Item $filePath
    $ext = $file.Extension.ToLower()
    
    if ($ext -eq ".pdf") {
        $byType["PDF"] += $file
    } elseif ($ext -eq ".zip") {
        $byType["ZIP"] += $file
    } elseif ($ext -match "\.(jpg|jpeg|png|gif|webp|svg)") {
        $byType["Images"] += $file
    } elseif ($ext -match "\.(docx?|doc|txt)") {
        $byType["Documents"] += $file
    } elseif ($ext -match "\.(csv|xlsx?|json)") {
        $byType["Data"] += $file
    } else {
        $byType["Other"] += $file
    }
}

# Display summary
Write-Host "Files by type:" -ForegroundColor Cyan
Write-Host "  PDFs: $($byType['PDF'].Count)" -ForegroundColor Yellow
Write-Host "  ZIPs: $($byType['ZIP'].Count)" -ForegroundColor Yellow
Write-Host "  Images: $($byType['Images'].Count)" -ForegroundColor Yellow
Write-Host "  Documents: $($byType['Documents'].Count)" -ForegroundColor Yellow
Write-Host "  Data: $($byType['Data'].Count)" -ForegroundColor Yellow
Write-Host "  Other: $($byType['Other'].Count)" -ForegroundColor Yellow
Write-Host ""

# Display files by location
Write-Host "Files by location:" -ForegroundColor Cyan
foreach ($location in $filesByLocation.Keys) {
    Write-Host "  $location : $($filesByLocation[$location].Count) file(s)" -ForegroundColor Gray
}
Write-Host ""

# Show file list
Write-Host "=== File List ===" -ForegroundColor Cyan
$fileNum = 1
foreach ($filePath in $allFiles) {
    $file = Get-Item $filePath
    Write-Host "$fileNum. $($file.Name)" -ForegroundColor Yellow
    Write-Host "   Location: $($file.DirectoryName)" -ForegroundColor Gray
    Write-Host "   Size: $([math]::Round($file.Length / 1KB, 2)) KB" -ForegroundColor Gray
    Write-Host ""
    $fileNum++
}

# Archive option
if (-not $DryRun) {
    Write-Host "=== Archiving Files ===" -ForegroundColor Cyan
    
    $archived = 0
    $skipped = 0
    
    foreach ($filePath in $allFiles) {
        $file = Get-Item $filePath
        
        # Create subdirectory based on file type
        $subDir = switch ($file.Extension.ToLower()) {
            ".pdf" { "pdfs" }
            ".zip" { "zips" }
            { $_ -match "\.(jpg|jpeg|png|gif|webp|svg)" } { "images" }
            { $_ -match "\.(docx?|doc|txt)" } { "documents" }
            { $_ -match "\.(csv|xlsx?|json)" } { "data" }
            default { "other" }
        }
        
        $targetDir = Join-Path $archiveRoot $subDir
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
        }
        
        $targetPath = Join-Path $targetDir $file.Name
        
        if (Test-Path $targetPath) {
            Write-Host "Skipped (exists): $($file.Name)" -ForegroundColor Gray
            $skipped++
        } else {
            Copy-Item $file.FullName -Destination $targetPath -Force
            Write-Host "Archived: $($file.Name) → $subDir\" -ForegroundColor Green
            $archived++
        }
    }
    
    Write-Host ""
    Write-Host "=== Archive Summary ===" -ForegroundColor Cyan
    Write-Host "Files archived: $archived" -ForegroundColor Green
    Write-Host "Files skipped: $skipped" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Archive location: $archiveRoot" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Note: Original files remain in their locations." -ForegroundColor Gray
    Write-Host "Review archived files, then delete originals manually if desired." -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "=== Dry Run Complete ===" -ForegroundColor Cyan
    Write-Host "Run without -DryRun to archive files." -ForegroundColor Yellow
}
