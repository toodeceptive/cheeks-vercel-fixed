# Fix Comprehensive Search Bug
# Fixes issue where temp files cause errors

param(
    [string]$ScriptPath = "$PSScriptRoot\comprehensive-file-search.ps1"
)

# Read the script
$content = Get-Content $ScriptPath -Raw

# Fix the bug - add error handling for missing files
$fix = @'
            foreach ($file in $files) {
                if ($allFiles -notcontains $file.FullName) {
                    # Skip if file doesn't exist (temp files may be deleted)
                    if (Test-Path $file.FullName) {
                        $allFiles += $file.FullName
                        $locationFiles += $file
                    }
                }
            }
'@

$oldPattern = 'foreach \(\$file in \$files\) \{[^}]+\}'

if ($content -match $oldPattern) {
    # Apply fix
    $newContent = $content -replace $oldPattern, $fix
    Set-Content -Path $ScriptPath -Value $newContent -NoNewline
    Write-Host "Fixed comprehensive-file-search.ps1" -ForegroundColor Green
} else {
    Write-Host "Pattern not found or already fixed" -ForegroundColor Yellow
}
