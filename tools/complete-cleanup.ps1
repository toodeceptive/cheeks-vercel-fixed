# Complete Cleanup Script - Master Script
# Runs all cleanup operations in sequence

param(
    [switch]$DryRun = $false,
    [switch]$SkipDesktop = $false,
    [switch]$SkipDownloads = $false,
    [switch]$SkipGitHub = $false
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  COMPREHENSIVE CLEANUP - CHEEKS PROJECT" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Dry Run: $DryRun" -ForegroundColor $(if ($DryRun) { "Yellow" } else { "Green" })
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptPath

# Phase 1: Desktop Folder Cleanup
if (-not $SkipDesktop) {
    Write-Host "=== Phase 1: Desktop Folder Cleanup ===" -ForegroundColor Cyan
    & "$scriptPath\cleanup-desktop-folder.ps1" -DryRun:$DryRun
    Write-Host ""
    
    Write-Host "=== Phase 1b: Final Desktop Pass ===" -ForegroundColor Cyan
    & "$scriptPath\cleanup-desktop-final.ps1" -DryRun:$DryRun
    Write-Host ""
}

# Phase 2: Downloads Cleanup
if (-not $SkipDownloads) {
    Write-Host "=== Phase 2: Downloads Cleanup ===" -ForegroundColor Cyan
    & "$scriptPath\cleanup-downloads.ps1" -DryRun:$DryRun
    Write-Host ""
}

# Phase 3: GitHub Cleanup (Manual steps)
if (-not $SkipGitHub) {
    Write-Host "=== Phase 3: GitHub Cleanup ===" -ForegroundColor Cyan
    Write-Host "GitHub cleanup requires manual steps:" -ForegroundColor Yellow
    Write-Host "1. Review branches: git branch -a" -ForegroundColor Gray
    Write-Host "2. Delete obsolete branches: git branch -d <branch>" -ForegroundColor Gray
    Write-Host "3. Remove worktrees: git worktree remove <path>" -ForegroundColor Gray
    Write-Host "4. Or use: tools/cleanup-worktrees.ps1" -ForegroundColor Gray
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  CLEANUP COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "This was a dry run. No files were modified." -ForegroundColor Yellow
    Write-Host "Run without -DryRun to execute cleanup." -ForegroundColor Yellow
} else {
    Write-Host "Cleanup executed. Review archived files before deleting originals." -ForegroundColor Green
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "1. Review archived files in docs/archive/desktop-files/" -ForegroundColor Gray
Write-Host "2. Verify nothing important was missed" -ForegroundColor Gray
Write-Host "3. Delete desktop/downloads originals if desired" -ForegroundColor Gray
Write-Host "4. Complete GitHub cleanup manually" -ForegroundColor Gray
Write-Host "5. Review Vercel configuration" -ForegroundColor Gray
