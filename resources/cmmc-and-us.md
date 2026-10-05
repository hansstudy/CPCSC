# CMMC and the US program

CPCSC and CMMC share a technical spine, the NIST SP 800-171 control set, and almost nothing else. A supplier selling into both markets complies with both, separately.

## Sources

| Source | What it covers |
|---|---|
| [32 CFR Part 170](https://www.ecfr.gov/current/title-32/subtitle-A/chapter-I/subchapter-G/part-170) | The CMMC program rule, in effect December 16, 2024. |
| [Federal Register: CMMC Program final rule](https://www.federalregister.gov/documents/2024/10/15/2024-22905/cybersecurity-maturity-model-certification-cmmc-program) | The October 15, 2024 publication of the rule. |
| [FAR 52.204-21](https://www.acquisition.gov/far/52.204-21) | The 15 basic safeguarding requirements behind CMMC Level 1. |
| [The Cyber AB](https://cyberab.org/) | The accreditation body for CMMC third-party assessment organizations (C3PAOs). |
| [DoD CIO: CMMC](https://dodcio.defense.gov/CMMC/) | The Department's program site. |
| [NIST SP 800-171 Rev 2](https://csrc.nist.gov/pubs/sp/800/171/r2/upd1/final) | The 110 requirements CMMC Level 2 assesses. |
| [NIST SP 800-172](https://csrc.nist.gov/pubs/sp/800/172/final) | The enhanced requirements behind CMMC Level 3. |

## Comparison

| | CPCSC (Canada) | CMMC (United States) |
|---|---|---|
| Owner | Public Services and Procurement Canada | Department of Defense, now Department of War |
| Standard | ITSP.10.171, adapted from NIST SP 800-171 Rev 3 | NIST SP 800-171 Rev 2 |
| Level 1 | 13 requirements | 15 requirements (FAR 52.204-21) |
| MFA at Level 1 | Required (`03.05.03`) | Not required |
| Level 2 | 98 requirements, third-party assessed every 3 years | 110 requirements |
| Level 3 | 130-plus controls, assessed by National Defence | Level 2 plus 24 requirements from NIST SP 800-172 |
| Assessors | Certification bodies accredited by the Standards Council of Canada | C3PAOs accredited by the Cyber AB |
| Results filed in | CanadaBuys | SPRS |
| Contract mechanism | Clauses in the solicitation and contract | DFARS 252.204-7021 and 252.204-7025 |
| Data protected | Specified Information | Controlled Unclassified Information and Federal Contract Information |
| Recognition | A valid CMMC certification may be accepted case by case for Level 1 | CPCSC not recognized |

## What trips people up

- Requirement `03.05.03` puts multi-factor authentication into CPCSC Level 1. CMMC Level 1 has none, so a shop that cleared CMMC Level 1 on passwords isn't at CPCSC Level 1.
- The gap between 98 and 110 doesn't mean Canada asks for less. NIST Rev 3 consolidated Rev 2's 110 requirements into 97, and Canada added `03.14.09`. Most of the content carries over. The numbering and grouping don't.
- There's no automatic mutual recognition. PSPC may accept a valid CMMC certification case by case for Level 1, after confirming its scope covers the Canadian contract data. Nothing published extends that to Level 2 or 3.
- CMMC allows limited POA&Ms closed within 180 days. CPCSC's Level 2 rules for open items haven't been published, so don't assume they'll match.
- Requirement `03.14.09` has no CMMC equivalent. It asks for administration from a dedicated, isolated workstation and, for remote connections, a carrier private network such as VPLS or MPLS with VPN encryption, which most MSP service models don't do today.

The comparison in full: [hans.study/cpcsc/vs-cmmc](https://hans.study/cpcsc/vs-cmmc/).
