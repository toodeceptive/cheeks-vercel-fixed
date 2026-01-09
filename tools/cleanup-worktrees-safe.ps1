# Safe Worktree Cleanup
# Removes detached HEAD worktrees after verification

param(
    [switch]$DryRun = $true,
    [switch]$Force = $false
)

Write-Host "=== Worktree Cleanup ===" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "DRY RUN MODE - No worktrees will be removed" -ForegroundColor Yellow
    Write-Host ""
}

# Get all worktrees
$worktrees = git worktree list --porcelain | Select-String "worktree" | ForEach-Object { 
    $_.Line -replace "worktree ", "" 
}

$mainWorktree = (Get-Location).Path
Write-Host "Main worktree (KEEP): $mainWorktree" -ForegroundColor Green
Write-Host ""

# Get detached HEAD worktrees
$detachedWorktrees = @()
foreach ($wt in $worktrees) {
    if ($wt -ne $mainWorktree) {
        $branch = git -C $wt rev-parse --abbrev-ref HEAD 2>$null
        if ($branch -eq "HEAD") {
            $detachedWorktrees += $wt
        }
    }
}

Write-Host "=== Detached HEAD Worktrees ===" -ForegroundColor Cyan
Write-Host "Found: $($detachedWorktrees.Count) worktrees" -ForegroundColor Yellow
Write-Host ""

if ($detachedWorktrees.Count -eq 0) {
    Write-Host "No detached HEAD worktrees to remove." -ForegroundColor Green
    exit 0
}

$num = 1
foreach ($wt in $detachedWorktrees) {
    $commit = git -C $wt rev-parse HEAD 2>$null
    Write-Host "$num. $wt" -ForegroundColor Yellow
    Write-Host "   Commit: $commit" -ForegroundColor Gray
    Write-Host ""
    $num++
}

if (-not $DryRun -and $Force) {
    Write-Host "Removing worktrees..." -ForegroundColor Yellow
    $removed = 0
    foreach ($wt in $detachedWorktrees) {
        try {
            git worktree remove $wt --force
            Write-Host "  ✅ Removed: $wt" -ForegroundColor Green
            $removed++
        } catch {
            Write-Host "  ❌ Error removing $wt : $_" -ForegroundColor Red
        }
    }
    Write-Host ""
    Write-Host "Removed: $removed / $($detachedWorktrees.Count) worktrees" -ForegroundColor Green
} else {
    Write-Host "DRY RUN: No worktrees removed. Use -DryRun:`$false -Force to remove." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To remove manually:" -ForegroundColor Gray
    foreach ($wt in $detachedWorktrees) {
        Write-Host "  git worktree remove $wt --force" -ForegroundColor Gray
    }
}
