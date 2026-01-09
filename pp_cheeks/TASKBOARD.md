# CHEEKS AUDIT TASKBOARD

**Agent 0 (Orchestrator)**: Single writer for canonical files  
**Status**: WAVE 0 - Bootstrap Complete | WAVE 1 - Discovery In Progress

---

## ROOT SCOPES (LOCKED BY AGENT 0)

### LOCAL_ROOTS
- **repo_roots**: 
  - `c:\Users\LegiT\Downloads\cheeks-vercel-fixed`
- **non_repo_roots**: 
  - `C:\Users\LegiT\Desktop` (for PDFs, screenshots, non-repo assets)

### WEB_TARGETS
- **domains**: 
  - `cheeksbar.com` (status: BLOCKED - access unknown, awaiting Angela response)
  - `cheeks-bar-and-grill.vercel.app` (current deployment)
- **live_deploy_urls**: 
  - `https://cheeks-bar-and-grill.vercel.app`
- **listings**: 
  - Apple Maps (pin correction submitted, pending)
  - Google Business Profile (to verify)
  - Yelp (known: `https://www.yelp.com/biz/cheeks-bar-and-grill-wausau`)
  - Facebook (known: `https://www.facebook.com/profile.php?id=61571389349445`)

### TIMEBOX RULE
- All tasks must be ≤90 minutes each
- Split larger tasks into smaller chunks

---

## OBJECTIVES

1. Exhaustively locate, audit, verify, reconcile, and summarize EVERYTHING related to "Cheeks Bar & Grill" (all name variants)
2. Create complete SSOT (Single Source of Truth)
3. Identify and resolve conflicts (address, domain, listings, pricing)
4. Generate ranked audit findings with evidence
5. Create staged change plan (PATCH_QUEUE)
6. Document proof-of-exhaustion

---

## WAVE ASSIGNMENTS

### WAVE 0 — Orchestration (Agent 0) ✅ COMPLETE
- [x] Create canonical files
- [x] Integrate operations/comms log
- [x] Lock root scopes
- [x] Assign Wave 1 tasks

### WAVE 1 — Discovery (All Agents) 🔄 IN PROGRESS

#### Agent 1 — Local Code Forensics
**Scope**: Repository code, pages, assets, configs  
**Status**: PENDING  
**Tasks**:
- [ ] Catalog all Cheeks-related files (HTML, JS, CSS, JSON, YAML)
- [ ] Extract business data (name variants, address, phone, email, hours)
- [ ] Identify content sources (menu, events, pricing)
- [ ] Document asset inventory (images, icons, PDFs)
**Output**: `pp_cheeks/outputs/agent1.local.md`

#### Agent 2 — Git Forensics
**Scope**: Git history, remotes, branches, commit provenance  
**Status**: PENDING  
**Tasks**:
- [ ] Identify remotes and branches
- [ ] Trace evolution of key artifacts (address changes, menu updates, pricing)
- [ ] Document commit history for business data changes
- [ ] Identify provenance of conflicting values
**Output**: `pp_cheeks/outputs/agent2.git.md`

#### Agent 3 — Deploy/Vercel Forensics
**Scope**: `vercel.json`, build configs, env vars (names only), deployment parity  
**Status**: PENDING  
**Tasks**:
- [ ] Document `vercel.json` configuration (rewrites, headers, redirects)
- [ ] Catalog environment variable NAMES (no values)
- [ ] Verify build commands and runtimes
- [ ] Check deployment parity (repo vs live)
**Output**: `pp_cheeks/outputs/agent3.deploy.md`

#### Agent 4 — Web Reality & SEO
**Scope**: Live URLs, domain resolution, indexability, listings  
**Status**: PENDING  
**Tasks**:
- [ ] Verify live deployment accessibility
- [ ] Check domain resolution (cheeksbar.com DNS)
- [ ] Document indexability (robots.txt, sitemap.xml, meta tags)
- [ ] Check listings consistency (Apple Maps, Google, Yelp, Facebook) - as accessible
- [ ] Document canonical URL strategy
**Output**: `pp_cheeks/outputs/agent4.web.md`

#### Agent 5 — Local Non-Repo Forensics
**Scope**: PDFs, screenshots, proposals, QR assets, logs  
**Status**: PENDING  
**Tasks**:
- [ ] Catalog non-repo files (Desktop PDFs, screenshots)
- [ ] Document QR code assets and URLs
- [ ] Extract business data from proposals/docs
- [ ] Cross-reference with operations log evidence
**Output**: `pp_cheeks/outputs/agent5.nonrepo.md`

### WAVE 2 — Classification & Conflicts (All Agents) ⏳ PENDING
- [ ] Classify artifacts (PRIMARY/SECONDARY/DERIVED/STALE/BLOCKED)
- [ ] Build conflict tables
- [ ] Resolve or block conflicts

### WAVE 3 — SSOT Build (Agent 0) ⏳ PENDING
- [ ] Create SSOT.cheeks.yaml structure
- [ ] Populate all sections
- [ ] Integrate operations log data
- [ ] Resolve conflicts

### WAVE 4 — Audit Findings (Agent 0) ⏳ PENDING
- [ ] Rank findings (Critical/High/Medium/Low)
- [ ] Document with evidence and patch references

### WAVE 5 — Live Parity (Agent 4 + Agent 3) ⏳ PENDING
- [ ] Verify deployment parity
- [ ] Verify listings parity
- [ ] Log mismatches to PATCH_QUEUE

### WAVE 6 — Negative Space (All Agents) ⏳ PENDING
- [ ] Identify expected-but-missing items
- [ ] Document gaps

### WAVE 7 — Promise Ledger (Agent 0) ⏳ PENDING
- [ ] Extract promises from operations log and comms
- [ ] Document status and remediation

### WAVE 8 — Convergence (Agent 0) ⏳ PENDING
- [ ] Verify all STOP CONDITIONS met
- [ ] Generate final deliverables

---

## DO-NOT-DUPLICATE SUMMARY

**Completed Searches**: See SEARCH_LEDGER.md  
**Completed Tasks**: See wave assignments above  
**Known Conflicts**: 
- Address: "4011 E Wausau Ave" (site) vs "158241 E Wausau Ave" (operations log)
- Domain: `cheeksbar.com` access status unknown
- Business Name: Multiple variants ("Cheeks Bar & Grill", "Cheeks Bar and Grill", "Cheek's Bar and Grill")

---

## ACCEPTANCE CRITERIA

### Per Wave:
- **Wave 1**: All agents complete discovery, all searches logged
- **Wave 2**: All artifacts classified, conflict tables complete
- **Wave 3**: SSOT complete with zero UNKNOWN fields
- **Wave 4**: All findings ranked and documented
- **Wave 5**: Parity verified, mismatches logged
- **Wave 6**: Gaps identified and documented
- **Wave 7**: All promises extracted and status documented
- **Wave 8**: All STOP CONDITIONS met, final deliverables complete

### Final:
- All accessible sources exhausted (SEARCH_LEDGER proves coverage)
- SSOT has zero UNKNOWN (resolved or BLOCKED)
- Conflicts resolved or justified with evidence
- High/Critical findings mapped to staged change plan
- SEARCH_LEDGER shows unique coverage per scope & purpose
- REPORT.final.md includes proof-of-exhaustion summary

---

**Last Updated**: [Will be updated as work progresses]
