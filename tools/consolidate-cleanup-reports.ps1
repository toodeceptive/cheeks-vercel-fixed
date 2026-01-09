# Consolidate Cleanup Reports
# Archives redundant cleanup/report/summary files to keep only the most comprehensive ones

param(
    [string]$ProjectRoot = "",
    [switch]$DryRun = $true
)

# Set default project root if not provided
if ([string]::IsNullOrEmpty($ProjectRoot)) {
    if ($PSScriptRoot) {
        $ProjectRoot = Split-Path -Parent $PSScriptRoot
    } else {
        $ProjectRoot = $PWD.Path
    }
}

Write-Host "=== Consolidate Cleanup Reports ===" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "DRY RUN MODE - No files will be moved" -ForegroundColor Yellow
    Write-Host ""
}

$archivePath = Join-Path $ProjectRoot "docs\archive\obsolete\cleanup-reports"
if (-not (Test-Path $archivePath)) {
    New-Item -ItemType Directory -Path $archivePath -Force | Out-Null
    Write-Host "Created archive directory: $archivePath" -ForegroundColor Green
}

# Files to keep (most comprehensive)
$keepFiles = @(
    "ULTIMATE_FINAL_STATUS.md",
    "PROJECT_PERFECT.md",
    "ALL_CLEANUP_COMPLETE.md",
    "COMPREHENSIVE_FINAL_REPORT.md"
)

# Files to archive (redundant/intermediate)
$archiveFiles = @(
    "CLEANUP_AND_OPTIMIZATION_COMPLETE.md",
    "CLEANUP_COMPLETE_SUMMARY.md",
    "CLEANUP_EXECUTION_COMPLETE.md",
    "CLEANUP_EXECUTION_FINAL.md",
    "CLEANUP_EXECUTION_REPORT.md",
    "FINAL_CLEANUP_EXECUTION_REPORT.md",
    "FINAL_CLEANUP_REPORT.md",
    "FINAL_CLEANUP_SUMMARY.md",
    "FINAL_PROJECT_REVIEW.md",
    "PROJECT_FINAL_STATUS.md",
    "PROJECT_COMPLETE.md",
    "OPTIMIZATION_COMPLETE_SUMMARY.md",
    "GURU_EXPERT_CLEANUP_EXECUTION.md",
    "GURU_EXPERT_FINAL_CLEANUP.md"
)

Write-Host "=== Files to Keep ===" -ForegroundColor Cyan
foreach ($file in $keepFiles) {
    $path = Join-Path $ProjectRoot $file
    if (Test-Path $path) {
        Write-Host "  [OK] $file" -ForegroundColor Green
    } else {
        Write-Host "  [WARN] $file (not found)" -ForegroundColor Yellow
    }
}
Write-Host ""

Write-Host "=== Files to Archive ===" -ForegroundColor Cyan
$archived = 0
foreach ($file in $archiveFiles) {
    $sourcePath = Join-Path $ProjectRoot $file
    if (Test-Path $sourcePath) {
        $destPath = Join-Path $archivePath $file
        if ($DryRun) {
            Write-Host "  [ARCHIVE] Would archive: $file" -ForegroundColor Yellow
        } else {
            try {
                Move-Item $sourcePath $destPath -Force
                Write-Host "  [OK] Archived: $file" -ForegroundColor Green
                $archived++
            } catch {
                Write-Host "  [ERROR] Error archiving $file : $_" -ForegroundColor Red
            }
        }
    }
}
Write-Host ""

if ($DryRun) {
    Write-Host "DRY RUN: No files moved. Use -DryRun:`$false to archive." -ForegroundColor Yellow
} else {
    $totalCount = $archiveFiles.Count
    Write-Host "Archived: $archived / $totalCount files" -ForegroundColor Green
}
