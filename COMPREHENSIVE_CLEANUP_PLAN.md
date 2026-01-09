# Comprehensive Cleanup Plan - Cheeks Bar & Grill Project
**Date**: 2026-01-09  
**Status**: 📋 READY TO EXECUTE  
**Scope**: Complete cleanup of all project-related files, documents, and locations

---

## 🎯 EXECUTIVE SUMMARY

This plan provides a systematic approach to cleaning all project-related files across:
- ✅ Project repository (local)
- ✅ GitHub (remote)
- ✅ Vercel (deployment)
- ✅ Desktop files
- ✅ Personal documents
- ✅ Downloads folder
- ✅ Worktrees
- ✅ Temporary files

---

## 📋 CLEANUP PHASES

### Phase 1: Project Repository Cleanup ✅ COMPLETE
**Status**: Already done in previous optimization

**What Was Done**:
- ✅ Archived 13 obsolete files
- ✅ Organized documentation structure
- ✅ Removed redundant files
- ✅ Updated all cross-references

**Remaining Actions**:
- [ ] Review archived files for final deletion (optional)
- [ ] Clean up any remaining temporary files

---

### Phase 2: Desktop Files Cleanup
**Location**: Desktop (`$env:USERPROFILE\Desktop`)

#### 2.1 Desktop Folder: `Cheek's Bar & Grill\`
**Location**: Desktop folder (`$env:USERPROFILE\Desktop\Cheek's Bar & Grill\`)

**Files Identified** (from SSOT):
- `Cheeks Logo.jpg`
- `Cheeks Owner (Angela Thomas).jpg`
- `Cheeks Owner (Ryan Thomas).jpg`
- `Cheeks Owners (Together).jpg`
- `Cheeks Owners (Together2).jpg`
- `Cheeks Sign.jpg`

**Action Plan**:
1. **Review files** - Check if these are still needed
2. **Option A (Keep)**: Move to project `assets/images/` if needed for website
3. **Option B (Archive)**: Move to `docs/archive/desktop-files/images/` if historical
4. **Option C (Delete)**: Delete if duplicates or no longer needed

**Script**: Create `tools/cleanup-desktop-folder.ps1`

#### 2.2 Desktop QR Code PDF
**Location**: Desktop (archived in project)

**Status**: Already copied to `docs/presentations/desktop-archive/pdfs/`

**Action Plan**:
1. **Verify**: Check if desktop copy is identical to archived copy
2. **Action**: Delete desktop copy (already archived)

#### 2.3 Other Desktop Files
**Pattern**: Files matching `*cheeks*`

**Action Plan**:
1. **Run**: `tools/organize-desktop-files.ps1` to find remaining files
2. **Review**: Check for any missed files
3. **Archive**: Move to appropriate archive location
4. **Delete**: Remove desktop originals after verification

---

### Phase 3: Downloads Folder Cleanup
**Location**: Downloads folder (`$env:USERPROFILE\Downloads`)

#### 3.1 Project Folder
**Location**: Downloads folder (project root)

**Status**: This is the active project folder

**Action Plan**:
- ✅ **Keep**: This is the main project folder
- [ ] **Verify**: Ensure no duplicate project folders exist
- [ ] **Check**: Look for old/backup versions

#### 3.2 ZIP Archives
**Pattern**: `*cheeks*.zip` or `*cheeks-vercel*.zip`

**Action Plan**:
1. **Find**: Search for ZIP files in Downloads
2. **Review**: Check if already archived in project
3. **Archive**: Move to `docs/archive/desktop-files/zip-archives/` if not already there
4. **Delete**: Remove from Downloads after archiving

---

### Phase 4: GitHub Cleanup
**Repository**: `toodeceptive/cheeks-vercel-fixed`

#### 4.1 Branches
**Action Plan**:
1. **List branches**: `git branch -a`
2. **Review**: Identify obsolete branches
3. **Delete local**: `git branch -d <branch-name>`
4. **Delete remote**: `git push origin --delete <branch-name>`

**Branches to Review**:
- `main` - ✅ Keep (primary branch)
- `multi-agent-clean-plan` - Review if obsolete
- `fix-linter-errors` - Review if obsolete
- Any other feature branches

#### 4.2 Worktrees
**Action Plan**:
1. **List worktrees**: `git worktree list`
2. **Review**: Identify unused worktrees
3. **Remove**: Use `tools/cleanup-worktrees.ps1` or manual removal

**Script**: `tools/cleanup-worktrees.ps1` (already exists)

#### 4.3 GitHub Issues/PRs
**Action Plan**:
1. **Review**: Check for open issues/PRs
2. **Close**: Close any obsolete issues/PRs
3. **Archive**: Archive completed items

#### 4.4 GitHub Releases/Tags
**Action Plan**:
1. **List tags**: `git tag -l`
2. **Review**: Identify obsolete tags
3. **Delete**: Remove if no longer needed

---

### Phase 5: Vercel Cleanup
**Project**: `cheeks-bar-and-grill` (or similar)

#### 5.1 Deployments
**Action Plan**:
1. **Review**: Check Vercel dashboard for old deployments
2. **Keep**: Production deployment
3. **Archive**: Old preview deployments (auto-archived by Vercel)
4. **Delete**: Failed/obsolete deployments if possible

#### 5.2 Environment Variables
**Action Plan**:
1. **Review**: Check all environment variables
2. **Verify**: Ensure all are current and needed
3. **Document**: Update `ENV_VARIABLES.md` if changes made
4. **Remove**: Delete any obsolete variables

#### 5.3 Domains
**Action Plan**:
1. **Review**: Check domain configuration
2. **Verify**: Ensure `cheeks-bar-and-grill.vercel.app` is primary
3. **Document**: Update if custom domain added (PATCH-002)

#### 5.4 Analytics/Logs
**Action Plan**:
1. **Export**: Export any important analytics data
2. **Archive**: Save to `docs/deployment/desktop-archive/data/` if needed
3. **Clear**: Clear old logs if desired (Vercel auto-rotates)

---

### Phase 6: Personal Documents Cleanup
**Locations to Check**:
- Documents folder (`$env:USERPROFILE\Documents`)
- OneDrive folder (`$env:USERPROFILE\OneDrive` - if applicable)
- Pictures folder (`$env:USERPROFILE\Pictures` - if project images stored there)

#### 6.1 Documents Folder
**Action Plan**:
1. **Search**: Find files matching `*cheeks*`
2. **Review**: Check if project-related
3. **Archive**: Move to project if relevant
4. **Delete**: Remove if obsolete

#### 6.2 Pictures Folder
**Action Plan**:
1. **Search**: Find images matching `*cheeks*` or `*cheek*`
2. **Review**: Check if needed for project
3. **Move**: Move to `assets/images/` if needed
4. **Archive**: Move to `docs/archive/desktop-files/images/` if historical

---

### Phase 7: Temporary Files Cleanup
**Locations**:
- `%TEMP%` folder
- Browser downloads
- Cursor cache
- Node modules (if any outside project)

#### 7.1 Temp Folder
**Action Plan**:
1. **Search**: Find `*cheeks*` files in temp
2. **Delete**: Remove temporary files

#### 7.2 Browser Downloads
**Action Plan**:
1. **Check**: Browser download history
2. **Review**: Project-related downloads
3. **Archive**: If important, move to project
4. **Delete**: Remove if obsolete

---

## 🛠️ CLEANUP SCRIPTS

### Script 1: Desktop Folder Cleanup
**File**: `tools/cleanup-desktop-folder.ps1`

**Purpose**: Clean up `Cheek's Bar & Grill\` desktop folder

### Script 2: Desktop Files Final Cleanup
**File**: `tools/cleanup-desktop-final.ps1`

**Purpose**: Final pass to find and clean any remaining desktop files

### Script 3: Downloads Cleanup
**File**: `tools/cleanup-downloads.ps1`

**Purpose**: Clean up Downloads folder

### Script 4: Complete Cleanup
**File**: `tools/complete-cleanup.ps1`

**Purpose**: Master script that runs all cleanup operations

---

## 📊 CLEANUP CHECKLIST

### Project Repository
- [x] Archive obsolete files
- [x] Organize documentation
- [x] Update cross-references
- [ ] Review archived files (optional deletion)
- [ ] Clean temporary files

### Desktop Files
- [ ] Review `Cheek's Bar & Grill\` folder
- [ ] Move/archive/delete images
- [ ] Delete QR code PDF (already archived)
- [ ] Final pass for any remaining files

### Downloads Folder
- [ ] Check for duplicate project folders
- [ ] Archive/delete ZIP files
- [ ] Clean up any project-related downloads

### GitHub
- [ ] Review and clean branches
- [ ] Remove obsolete worktrees
- [ ] Close obsolete issues/PRs
- [ ] Review/delete tags

### Vercel
- [ ] Review deployments
- [ ] Verify environment variables
- [ ] Check domain configuration
- [ ] Export/archive analytics if needed

### Personal Documents
- [ ] Search Documents folder
- [ ] Search Pictures folder
- [ ] Search OneDrive (if applicable)
- [ ] Archive or delete found files

### Temporary Files
- [ ] Clean temp folder
- [ ] Check browser downloads
- [ ] Clear Cursor cache (if needed)

---

## ⚠️ SAFETY PRECAUTIONS

### Before Deletion
1. **Verify**: Always verify files are backed up/archived
2. **Test**: Test that archived files are accessible
3. **Document**: Document what was deleted and why
4. **Confirm**: Get confirmation before permanent deletion

### Backup Strategy
1. **Archive First**: Always archive before deleting
2. **Keep Copies**: Keep important files in project archive
3. **Verify**: Verify archives are complete before deletion
4. **Document**: Document all cleanup actions

---

## 🎯 EXECUTION ORDER

### Step 1: Create Cleanup Scripts
1. Create all cleanup scripts
2. Test scripts in dry-run mode
3. Review script output

### Step 2: Archive Everything
1. Run archive operations
2. Verify archives are complete
3. Document what was archived

### Step 3: Review and Verify
1. Review all archived files
2. Verify nothing important was missed
3. Get approval for deletions

### Step 4: Execute Cleanup
1. Run cleanup scripts
2. Manual cleanup where needed
3. Verify cleanup is complete

### Step 5: Final Verification
1. Verify project still works
2. Verify GitHub is clean
3. Verify Vercel is configured correctly
4. Document cleanup completion

---

## 📝 CLEANUP LOG

**Date**: 2026-01-09  
**Status**: Plan created, ready for execution

### Completed
- ✅ Project repository optimization
- ✅ Documentation organization
- ✅ Obsolete files archived

### Pending
- [ ] Desktop folder cleanup
- [ ] Downloads cleanup
- [ ] GitHub cleanup
- [ ] Vercel review
- [ ] Personal documents cleanup
- [ ] Temporary files cleanup

---

## 🎯 NEXT STEPS

1. **Review this plan** - Ensure all areas are covered
2. **Create cleanup scripts** - Automate where possible
3. **Execute Phase 2** - Desktop files cleanup
4. **Execute Phase 3** - Downloads cleanup
5. **Execute Phase 4** - GitHub cleanup
6. **Execute Phase 5** - Vercel review
7. **Execute Phase 6** - Personal documents
8. **Execute Phase 7** - Temporary files
9. **Final verification** - Ensure everything is clean

---

**Plan Status**: ✅ COMPLETE  
**Ready to Execute**: ✅ YES  
**Estimated Time**: 2-3 hours (with careful review)
