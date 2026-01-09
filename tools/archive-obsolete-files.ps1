# Archive Obsolete Files
# Moves obsolete documentation files to archive directories

$ErrorActionPreference = "Stop"

# Debug files
$debugFiles = @(
    "DEBUG_COMPLETE_VERIFICATION.md",
    "DEBUG_MERGE_ANALYSIS.md",
    "DEBUG_MERGE_RESOLUTION.md"
)

# Intermediate analysis files
$analysisFiles = @(
    "COMPREHENSIVE_GURU_ANALYSIS.md",
    "COMPREHENSIVE_STRATEGIC_ANALYSIS.md",
    "FINAL_GURU_EXPERT_REPORT.md",
    "FINAL_OPTIMIZATION_SUMMARY.md",
    "GURU_EXPERT_FINAL_SUMMARY.md",
    "ULTIMATE_GURU_EXPERT_FINAL_REPORT.md"
)

# Historical status files
$statusFiles = @(
    "LINTER_FIXES_COMPLETE.md",
    "NEXT_ACTIONS_AFTER_STASH.md",
    "FINAL_OPTIMIZATION_COMPLETE.md"
)

Write-Host "Archiving obsolete files..."

# Archive debug files
foreach ($file in $debugFiles) {
    if (Test-Path $file) {
        $dest = "docs\archive\obsolete\debug\$file"
        Move-Item $file $dest -Force
        Write-Host "Archived: $file"
    }
}

# Archive analysis files
foreach ($file in $analysisFiles) {
    if (Test-Path $file) {
        $dest = "docs\archive\obsolete\intermediate-analysis\$file"
        Move-Item $file $dest -Force
        Write-Host "Archived: $file"
    }
}

# Archive status files
foreach ($file in $statusFiles) {
    if (Test-Path $file) {
        $dest = "docs\archive\obsolete\historical-status\$file"
        Move-Item $file $dest -Force
        Write-Host "Archived: $file"
    }
}

Write-Host "Archive complete!"
