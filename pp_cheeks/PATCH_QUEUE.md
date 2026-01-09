# PATCH QUEUE

**Purpose**: Staged change proposals (no direct edits during audit waves)  
**Format**: `id | proposed_by | target | summary | rationale | evidence_refs | patch_steps | risk | rollback`

---

## PATCH PROPOSALS

| id | proposed_by | target | summary | rationale | evidence_refs | patch_steps | risk | rollback |
|----|-------------|--------|---------|-----------|---------------|-------------|------|----------|
| PATCH-001 | Agent 0 | verify/schema_presence_proof.txt | Update outdated verification file | File shows incorrect address "158241", should show "4011" | `verify/schema_presence_proof.txt:6`, `AUDIT_FINDINGS.md:FINDING-CRIT-001` | ✅ COMPLETE: Updated address to "4011 E Wausau Ave" | LOW | Revert file if needed |
| PATCH-002 | Agent 0 | Domain strategy | Finalize domain configuration | Domain access status unknown, awaiting Angela response | `OPERATIONS_LOG.md:MSG-003`, `AUDIT_FINDINGS.md:FINDING-CRIT-002` | 1. Wait for domain access confirmation from Angela<br>2. If access granted: Configure DNS/redirects in Vercel<br>3. If no access: Document fallback strategy | LOW | No changes until confirmed |
| PATCH-003 | Agent 0 | Apple Maps links | Standardize Apple Maps links after pin correction | Pin correction submitted, need to verify links once confirmed | `OPERATIONS_LOG.md:AM-F3`, `AUDIT_FINDINGS.md:FINDING-HIGH-001` | 1. Monitor Apple Maps for pin correction confirmation<br>2. Verify pin location is correct<br>3. Update map links if needed<br>4. Update QR code destinations if needed | LOW | No changes until pin confirmed |
| PATCH-004 | Agent 0 | QR code PDF | Add source parameter to QR code URL | Current URL lacks source tracking parameter | `agent5.nonrepo.md:68-71` (archived), `AUDIT_FINDINGS.md:FINDING-HIGH-002` | ✅ COMPLETE: QR code generated with `?src=qr-table-tent` parameter<br>1. Generated QR code PNG: `assets/images/qr-table-tent.png`<br>2. URL: `https://cheeks-bar-and-grill.vercel.app/?src=qr-table-tent`<br>3. Source tracking ready for testing<br>4. PDF can be generated from PNG if needed | LOW | Revert QR code if needed |
| PATCH-005 | Agent 0 | schema.json, index.html | Add Google Business Profile URL | Missing Google Business Profile reference in listings | `agent4.web.md` (archived), `AUDIT_FINDINGS.md:FINDING-HIGH-003` | 📝 DOCUMENTED: See `docs/reference/GOOGLE_BUSINESS_PROFILE_SETUP.md`<br>1. Obtain Google Business Profile URL from business owners<br>2. Add to `sameAs` array in schema.json<br>3. Add to `sameAs` in index.html JSON-LD<br>4. Verify on live site | LOW | Remove URL if incorrect |
| PATCH-006 | Agent 0 | index.html | Standardize business name | Minor inconsistency in name variants | `AUDIT_FINDINGS.md:FINDING-MED-001` | 1. Review name usage<br>2. Standardize to "Cheeks Bar and Grill" for body<br>3. Keep "Cheeks Bar & Grill" for title (acceptable) | LOW | Revert if needed |
| PATCH-007 | Agent 0 | assets/images/ | Add missing staff image | HTML references staff.webp but file missing | `agent1.local.md` (archived), `AUDIT_FINDINGS.md:FINDING-MED-003` | ✅ VERIFIED: Fallback handling in `app.js:58-68` gracefully handles missing image<br>Optional: Add staff.webp image to assets/images/ if desired | LOW | Remove image or reference if needed |
| PATCH-008 | Agent 0 | verify/schema_presence_proof.txt | Update or remove outdated file | File contains incorrect address | `AUDIT_FINDINGS.md:FINDING-LOW-001` | ✅ COMPLETE: Updated address to "4011 E Wausau Ave" (same as PATCH-001) | LOW | Revert if needed |

---

**Note**: Patches will be added as conflicts and gaps are identified during audit waves.

---

## STATUS SUMMARY (Last Updated: 2026-01-09)

- **Complete**: 3 patches (PATCH-001/PATCH-008, PATCH-007, PATCH-004)
- **Documented & Ready**: 1 patch (PATCH-005)
- **Blocked**: 2 patches (PATCH-002, PATCH-003)
- **Low Priority**: 1 patch (PATCH-006)

**Next Actions**: 
1. Add Google Business Profile URL (PATCH-005) - 10 minutes (after getting URL from owners)
2. Optional: Standardize business name (PATCH-006) - 5 minutes

**See**: `AGENT_HANDOFF.md` for continuation instructions
