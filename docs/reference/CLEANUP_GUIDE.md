# Cleanup Guide - Project File Organization
**Date**: 2026-01-09  
**Status**: ✅ COMPLETE  
**Purpose**: Generic guide for cleaning up project-related files

---

## 🎯 OVERVIEW

This guide provides instructions for cleaning up project-related files from your local machine without exposing personal information.

---

## 📋 CLEANUP LOCATIONS

### Desktop
- **Path**: Use `$env:USERPROFILE\Desktop` (PowerShell) or `%USERPROFILE%\Desktop` (CMD)
- **Files**: Project PDFs, images, ZIP archives, documents

### Downloads
- **Path**: Use `$env:USERPROFILE\Downloads` (PowerShell) or `%USERPROFILE%\Downloads` (CMD)
- **Files**: Project ZIP files, archives

### Documents
- **Path**: Use `$env:USERPROFILE\Documents` (PowerShell)
- **Files**: Project documents, notes

---

## 🛠️ CLEANUP TOOLS

### Available Scripts
All scripts use environment variables and avoid hardcoded paths:

1. **`comprehensive-file-search.ps1`** - Find all project files
2. **`find-sensitive-files.ps1`** - Find sensitive files
3. **`delete-desktop-originals.ps1`** - Safely delete archived files
4. **`cleanup-desktop-folder.ps1`** - Desktop folder cleanup
5. **`cleanup-desktop-final.ps1`** - Final desktop pass
6. **`cleanup-downloads.ps1`** - Downloads cleanup
7. **`complete-cleanup.ps1`** - Master cleanup script

### Usage
```powershell
# Find all files (dry run)
.\tools\comprehensive-file-search.ps1 -DryRun

# Find sensitive files
.\tools\find-sensitive-files.ps1

# Delete desktop originals (after review)
.\tools\delete-desktop-originals.ps1 -DryRun:$false -Force
```

---

## ⚠️ SECURITY NOTES

### Sensitive Files
If you find files with names like:
- `API Keys.txt`
- `*password*`
- `*secret*`
- `*token*`

**Action**:
1. Review contents immediately
2. If contains secrets:
   - Move to password manager
   - Verify in Vercel environment variables
   - Rotate if exposed
   - Delete from desktop
3. Never commit sensitive files to Git

---

## 📁 ARCHIVE STRUCTURE

Files are archived to:
```
docs/archive/desktop-files/
├── comprehensive-cleanup/
│   ├── pdfs/
│   ├── zips/
│   ├── images/
│   ├── documents/
│   └── data/
├── downloads/
├── misc/
└── zip-archives/
```

---

## ✅ CLEANUP CHECKLIST

- [ ] Run comprehensive file search
- [ ] Review found files
- [ ] Archive project files
- [ ] Review sensitive files (if any)
- [ ] Delete desktop originals (after verification)
- [ ] Verify all important files are archived

---

**Last Updated**: 2026-01-09  
**Status**: ✅ COMPLETE
