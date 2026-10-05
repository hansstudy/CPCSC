# CPCSC Level 1 crosswalk

CPCSC Level 1's 13 requirements against NIST SP 800-171 Rev 3, Rev 2, and CMMC Level 1 (the 15 basic safeguarding requirements of FAR 52.204-21).

ITSP.10.171 keeps the NIST SP 800-171 Rev 3 identifiers, so the ITSP and Rev 3 columns match by design. The Rev 2 and CMMC columns are this project's reading of how the requirements line up; confirm against NIST's official Rev 2 to Rev 3 crosswalk and PSPC's Level 1 criteria before relying on them in an assessment.

| ITSP.10.171 / Rev 3 | Requirement | NIST SP 800-171 Rev 2 | CMMC Level 1 | Evidence to keep |
|---|---|---|---|---|
| `03.01.01` | Account management | 3.1.1 | FAR b.1.i | Account list with owners; disable and review dates |
| `03.01.02` | Access enforcement | 3.1.2 | FAR b.1.ii | Group permissions on Specified Information shares; screenshots |
| `03.01.20` | Use of external systems | 3.1.20 | FAR b.1.iii | Policy on personal and external systems; agreements |
| `03.01.22` | Publicly accessible content | 3.1.22 | FAR b.1.iv | Review record for website and social posts |
| `03.05.01` | User identification, authentication, and re-authentication | 3.5.1, 3.5.2 | FAR b.1.v, b.1.vi | Unique user IDs; no shared logins; re-authentication settings |
| `03.05.02` | Device identification and authentication | 3.5.1, 3.5.2 | FAR b.1.v, b.1.vi | Device inventory; 802.1X or equivalent where used |
| `03.05.03` | Multi-factor authentication | 3.5.3 | Not in Level 1 (CMMC Level 2, IA.L2-3.5.3) | MFA policy and enrolment report covering every account |
| `03.08.03` | Media sanitization | 3.8.3 | FAR b.1.vii | Sanitization and destruction log with method |
| `03.10.01` | Physical access authorizations | 3.10.1 | FAR b.1.viii | Approved access list; review dates |
| `03.10.07` | Physical access control | 3.10.3, 3.10.4, 3.10.5 | FAR b.1.ix | Door control, visitor log, key and card control, output devices |
| `03.13.01` | Boundary protection | 3.13.1, 3.13.5 | FAR b.1.x, b.1.xi | Firewall rule set; managed interfaces; segmentation diagram |
| `03.14.01` | Flaw remediation | 3.14.1 | FAR b.1.xii | Patch windows defined; patch reports |
| `03.14.02` | Malicious code protection | 3.14.2, 3.14.4, 3.14.5 | FAR b.1.xiii, b.1.xiv, b.1.xv | Endpoint console showing current, scanning, blocking |

## What the mapping shows

On this reading, all 15 FAR requirements behind CMMC Level 1 fall inside CPCSC Level 1's 13, because Rev 3 consolidated several Rev 2 requirements (physical access logs, escorts, and access devices into `03.10.07`; signature updates and scans into `03.14.02`; public subnetworks into `03.13.01`).

CPCSC Level 1 then adds one requirement CMMC Level 1 doesn't have: `03.05.03`, multi-factor authentication. The standard's text covers privileged and non-privileged accounts; PSPC's Level 1 guidance describes MFA as required for privileged accounts and for systems that store Specified Information. A shop that cleared CMMC Level 1 on passwords is not at CPCSC Level 1 yet.

PSPC may accept a valid CMMC certification case by case for Level 1, after confirming its scope covers the Canadian contract data. There's no automatic mutual recognition, and nothing published extends that acceptance past Level 1.
