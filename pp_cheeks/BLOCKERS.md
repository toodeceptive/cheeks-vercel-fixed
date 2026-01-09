# BLOCKERS

**Purpose**: Items that exist but are inaccessible, requiring user action  
**Format**: `id | item | why_blocked | required_action | impact | workaround | owner`

---

## BLOCKED ITEMS

| id | item | why_blocked | required_action | impact | workaround | owner |
|----|------|-------------|-----------------|--------|------------|-------|
| BLOCK-001 | `cheeksbar.com` domain access | Unknown if Angela/Ryan have access or are working with previous developer | Angela must confirm domain access status | Cannot finalize domain strategy, cannot configure DNS/redirects | Use `cheeks-bar-and-grill.vercel.app` as primary until resolved | Angela (via Cody) |
| BLOCK-002 | Apple Maps pin correction confirmation | Correction submitted but no confirmation received yet | Monitor Apple Maps for pin update or confirmation notification | Cannot standardize map links until pin is confirmed correct | Use current map links, update after confirmation | Apple Maps (pending) |
| BLOCK-003 | Address verification | ~~Conflict between "4011 E Wausau Ave" (site) and "158241 E Wausau Ave" (operations log)~~ | ~~Verify correct address with owner/Google Maps/Apple Maps~~ | ~~Cannot resolve address conflict in SSOT~~ | ~~Mark as conflict in SSOT until verified~~ | ~~Owner/Angela~~ |
| | | **RESOLVED** - Evidence confirms "4011 E Wausau Ave" is correct. "158241" was user error in Apple Maps report UI. | ✅ RESOLVED | ✅ RESOLVED | ✅ RESOLVED | ✅ RESOLVED |

---

**Note**: Blockers will be updated as audit progresses and items are resolved or new blockers are identified.

---

## RESOLVED BLOCKERS

### BLOCK-003: Address Verification ✅ RESOLVED
**Original Issue**: Conflict between "4011 E Wausau Ave" (site) and "158241 E Wausau Ave" (operations log)  
**Resolution**: Evidence confirms "4011 E Wausau Ave" is correct. The "158241" value was a user error in Apple Maps report UI or outdated test data.  
**Evidence**: Git history, live site, all code sources consistently use "4011". See `AUDIT_FINDINGS.md:FINDING-CRIT-001` and `REPORT.final.md` for details.  
**Status**: ✅ RESOLVED - No action required
