# GitHub Cleanup Guide
**Date**: 2026-01-09  
**Purpose**: Guide for cleaning up GitHub branches and worktrees

---

## 🔍 CURRENT STATE ANALYSIS

### Branches
Run `git branch -a` to see all branches.

**Local Branches**:
- `main` ✅ (keep - primary branch)
- `fix-linter-errors` ⚠️ (review - may be merged)
- `multi-agent-clean-plan` ⚠️ (review - may be merged)

**Remote Branches**:
- `origin/main` ✅ (keep)
- `origin/fix-linter-errors` ⚠️ (review)
- `origin/multi-agent-clean-plan` ⚠️ (review)
- `origin/shipset-v1-fix` ⚠️ (likely obsolete)
- `origin/https/cheeks-bar-and-grill-prodigyproject.vercel.app` ⚠️ (Vercel auto-branch)

### Worktrees
Run `git worktree list` to see all worktrees.

**Expected Worktrees**:
- Main worktree (project root) ✅ (keep)
- Cursor worktrees (if active) ⚠️ (review)

**Detached HEAD Worktrees**:
- 10+ detached HEAD worktrees ⚠️ (can be removed)

---

## 🧹 CLEANUP STEPS

### Step 1: Review Branch Commits

```bash
# Check if branches have unique commits
git log main..fix-linter-errors --oneline
git log main..multi-agent-clean-plan --oneline
```

**Decision**:
- If no unique commits: Safe to delete
- If unique commits: Review and merge if needed

### Step 2: Delete Obsolete Branches

```bash
# Delete local branch (if merged)
git branch -d fix-linter-errors
git branch -d multi-agent-clean-plan

# Force delete if needed (after review)
git branch -D branch-name

# Delete remote branch
git push origin --delete fix-linter-errors
git push origin --delete multi-agent-clean-plan
```

### Step 3: Clean Up Worktrees

```bash
# List all worktrees
git worktree list

# Remove a worktree (replace <path> with actual path)
git worktree remove <path>

# Example for detached HEAD worktrees:
git worktree remove C:/Users/LegiT/.cursor/worktrees/cheeks-vercel-fixed/fxc
git worktree remove C:/Users/LegiT/.cursor/worktrees/cheeks-vercel-fixed/ins
# (repeat for each detached HEAD worktree)
```

**⚠️ Warning**: Only remove worktrees that are not actively in use!

### Step 4: Clean Up Remote Branches

```bash
# Prune remote branches that no longer exist
git remote prune origin

# Delete remote branch
git push origin --delete branch-name
```

---

## ✅ VERIFICATION

After cleanup, verify:

```bash
# Check branches
git branch -a

# Check worktrees
git worktree list

# Check remote status
git remote show origin
```

---

## 📋 CLEANUP CHECKLIST

- [ ] Review branch commits
- [ ] Delete merged/obsolete local branches
- [ ] Delete merged/obsolete remote branches
- [ ] Remove detached HEAD worktrees
- [ ] Prune remote references
- [ ] Verify cleanup complete

---

**Last Updated**: 2026-01-09
