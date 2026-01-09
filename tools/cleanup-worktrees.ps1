# Worktree Cleanup Script
# Removes unused worktrees to prevent conflicts

$worktrees = git worktree list --porcelain | Select-String "worktree" | ForEach-Object { $_.Line -replace "worktree ", "" }

Write-Host "=== Worktree Cleanup Analysis ===" -ForegroundColor Cyan
Write-Host ""

# Main worktree (keep) - use current location or environment variable
$mainWorktree = if ($env:PROJECT_ROOT) { $env:PROJECT_ROOT } else { (Get-Location).Path }
Write-Host "Main worktree (KEEP): $mainWorktree" -ForegroundColor Green

# Current worktree (keep if active)
$currentWorktree = (Get-Location).Path
Write-Host "Current worktree: $currentWorktree" -ForegroundColor Yellow

# List all worktrees
Write-Host "`nAll worktrees:" -ForegroundColor Cyan
git worktree list

Write-Host "`n=== Recommendation ===" -ForegroundColor Cyan
Write-Host "Keep: Main worktree at Downloads/" -ForegroundColor Green
Write-Host "Review: Cursor worktrees - remove if not actively used" -ForegroundColor Yellow
Write-Host ""
Write-Host "To remove a worktree:" -ForegroundColor Gray
Write-Host "  git worktree remove <path>" -ForegroundColor Gray
Write-Host ""
Write-Host "Note: Only remove worktrees that are not actively in use!" -ForegroundColor Yellow
