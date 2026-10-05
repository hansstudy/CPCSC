# CPCSC Level 1 checklist

The 13 requirements CPCSC Level 1 assesses, with the evidence to keep for each. Answer them against the systems inside your boundary only, after you've mapped where Specified Information lives.

## Before you answer

- [ ] Contracts with Specified Information clauses listed
- [ ] Data flow mapped; boundary drawn and dated (see PSPC's CPCSC Level 1 Scoping Guide)
- [ ] Evidence folder created, one subfolder per requirement
- [ ] Active CanadaBuys account and supplier profile

## The 13 requirements

| Done | ITSP.10.171 | Requirement | Evidence | Rev 2 | CMMC Level 1 |
|---|---|---|---|---|---|
| [ ] | `03.01.01` | Account management | Account list with owners; disable and review dates | 3.1.1 | FAR b.1.i |
| [ ] | `03.01.02` | Access enforcement | Group permissions on Specified Information shares; screenshots | 3.1.2 | FAR b.1.ii |
| [ ] | `03.01.20` | Use of external systems | Policy on personal and external systems; agreements | 3.1.20 | FAR b.1.iii |
| [ ] | `03.01.22` | Publicly accessible content | Review record for website and social posts | 3.1.22 | FAR b.1.iv |
| [ ] | `03.05.01` | User identification, authentication, and re-authentication | Unique user IDs; no shared logins; re-authentication settings | 3.5.1, 3.5.2 | FAR b.1.v, b.1.vi |
| [ ] | `03.05.02` | Device identification and authentication | Device inventory; 802.1X or equivalent where used | 3.5.1, 3.5.2 | FAR b.1.v, b.1.vi |
| [ ] | `03.05.03` | Multi-factor authentication | MFA policy and enrolment report covering every account | 3.5.3 | Not in Level 1 (CMMC Level 2, IA.L2-3.5.3) |
| [ ] | `03.08.03` | Media sanitization | Sanitization and destruction log with method | 3.8.3 | FAR b.1.vii |
| [ ] | `03.10.01` | Physical access authorizations | Approved access list; review dates | 3.10.1 | FAR b.1.viii |
| [ ] | `03.10.07` | Physical access control | Door control, visitor log, key and card control, output devices | 3.10.3, 3.10.4, 3.10.5 | FAR b.1.ix |
| [ ] | `03.13.01` | Boundary protection | Firewall rule set; managed interfaces; segmentation diagram | 3.13.1, 3.13.5 | FAR b.1.x, b.1.xi |
| [ ] | `03.14.01` | Flaw remediation | Patch windows defined; patch reports | 3.14.1 | FAR b.1.xii |
| [ ] | `03.14.02` | Malicious code protection | Endpoint console showing current, scanning, blocking | 3.14.2, 3.14.4, 3.14.5 | FAR b.1.xiii, b.1.xiv, b.1.xv |

## Filing

- [ ] Self-assessment completed with PSPC's online tool (cyberpostureassessments.ops.cyber.gc.ca/cpcsc-pccc), or CMMC certification proof sent to PSPC for a case-by-case decision
- [ ] Results page with expiry date saved to the evidence folder
- [ ] Result and expiry date confirmed in the CanadaBuys organizational supplier profile questionnaire
- [ ] Proof included with bids on contracts that require Level 1 (required at contract award)
- [ ] Evidence kept for the attestation cycle or at least one year
- [ ] Renewal calendared a month before expiry

Run `scripts/Invoke-CpcscEndpointAudit.ps1` on in-scope Windows machines for the technical evidence behind `03.01.01`, `03.13.01`, `03.14.01`, and `03.14.02`.
