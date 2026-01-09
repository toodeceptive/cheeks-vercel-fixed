# Continuation Prompt for AI Agents
## Use this when resuming work in "Agents in Command" tab

```
I'm continuing work on the Cheeks Bar & Grill project. Please:

1. Read AGENT_HANDOFF.md to understand the current state
2. Review pp_cheeks/PATCH_QUEUE.md for pending patches
3. Check what actions are ready to proceed (PATCH-004, PATCH-005)
4. Start with the highest priority actionable patch
5. Update PATCH_QUEUE.md when completing patches

Current status:
- Audit: COMPLETE
- Cursor optimizations: COMPLETE  
- Patches: 2 complete, 2 documented (ready), 2 blocked, 1 low priority

Next actions:
- PATCH-004: Update QR code with source parameter (15 min)
- PATCH-005: Add Google Business Profile URL (10 min, needs URL first)

Blockers:
- PATCH-002: Domain access (awaiting Angela)
- PATCH-003: Apple Maps (awaiting Apple)

All documentation is in place. Please proceed with the next actionable patch.
```

---

## Quick Start Commands

**To check status:**
- Read `AGENT_HANDOFF.md`
- Check `pp_cheeks/PATCH_QUEUE.md`

**To continue work:**
- Start with PATCH-004 or PATCH-005 (both documented)
- Follow instructions in `docs/reference/` directory
- Update PATCH_QUEUE.md when done

**To understand project:**
- Read `pp_cheeks/SSOT.cheeks.yaml` for business data
- Read `pp_cheeks/AUDIT_FINDINGS.md` for all findings
- Read `README.md` for system overview
