# Government sources

These are the documents a contract or an assessor will point to. Start here.

## CPCSC program

| Source | What it covers |
|---|---|
| [Cyber security certification for defence suppliers in Canada: program overview](https://www.canada.ca/en/public-services-procurement/services/industrial-security/security-requirements-contracting/cyber-security-certification-defence-suppliers-canada/program-overview.html) | PSPC's description of CPCSC: the federal bodies and their roles, the 5 outcomes, the 3 levels, and the risk-based approach. Revised September 29, 2026. |
| [Canadian Program for Cyber Security Certification: Level 1](https://www.canada.ca/en/public-services-procurement/news/2026/04/canadian-program-for-cyber-security-certification-level-1.html) | The April 14, 2026 announcement of Level 1. |
| [How to meet Level 1 requirements](https://www.canada.ca/en/public-services-procurement/services/industrial-security/security-requirements-contracting/cyber-security-certification-defence-suppliers-canada/meet-level1-certification-requirements.html) | The 13 requirements and PSPC's assessment criteria, a Canadian version of NIST SP 800-171A Revision 3. |
| [Level 1 scoping guide](https://www.canada.ca/en/public-services-procurement/services/industrial-security/security-requirements-contracting/cyber-security-certification-defence-suppliers-canada/meet-level1-certification-requirements/scoping-guide.html) | How to draw the boundary before you answer the 13. |
| [CPCSC Level 1 self-assessment tool](https://cyberpostureassessments.ops.cyber.gc.ca/cpcsc-pccc) | The online tool for the annual self-assessment. |
| [CanadaBuys](https://canadabuys.canada.ca/en) | The procurement portal where the result and expiry date are confirmed in your supplier profile. |
| [Standards Council of Canada: CPCSC accreditation](https://scc-ccn.ca/accreditation-scheme/inspection-bodies/canadian-program-cyber-security-certification) | Accreditation of the certification bodies that will perform Level 2 assessments. |

## Canadian Centre for Cyber Security

| Source | What it covers |
|---|---|
| [ITSP.10.171 (HTML)](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171) and [PDF](https://www.cyber.gc.ca/sites/default/files/itsp10171-e-v4.pdf) | The technical standard: all 98 requirements, discussion text, tailoring criteria, and organization-defined parameters. First release April 2, 2025, second release October 28, 2025. |
| [Alerts and advisories](https://www.cyber.gc.ca/en/alerts-advisories) | The feed `03.14.03` expects you to receive. |
| [Baseline cyber security controls for small and medium organizations](https://www.cyber.gc.ca/en/guidance/baseline-cyber-security-controls-small-and-medium-organizations) | A smaller set of practical controls that overlaps heavily with Level 1. |
| [CyberSecure Canada](https://ised-isde.canada.ca/site/cybersecure-canada/en) | The federal certification program for small and medium organizations. A separate program from CPCSC, with a lighter control set. |

## Cyber Centre guidance behind specific requirements

ITSP.10.171 points to these from individual requirements.

| Publication | Useful for |
|---|---|
| [IT media sanitization (ITSP.40.006)](https://www.cyber.gc.ca/en/guidance/it-media-sanitization-itsp40006) | [`03.08.03`](../controls/08-media-protection.md#030803-media-sanitization-level-1) |
| [User authentication guidance for IT systems (ITSP.30.031 v3)](https://www.cyber.gc.ca/en/guidance/user-authentication-guidance-information-technology-systems-itsp30031-v3) | [`03.05.01` to `03.05.03`](../controls/05-identification-and-authentication.md), including MFA |
| [Guidance on securely configuring network protocols (ITSP.40.062)](https://www.cyber.gc.ca/en/guidance/guidance-securely-configuring-network-protocols-itsp40062) | [`03.13.08`](../controls/13-system-and-communications-protection.md) and `03.13.11`, TLS and cryptographic settings |
| [Baseline security requirements for network security zones (ITSP.80.022)](https://www.cyber.gc.ca/en/guidance/baseline-security-requirements-network-security-zones-version-20-itsp80022) | [`03.13.01`](../controls/13-system-and-communications-protection.md) boundary protection and segmentation |
| [Supply chain security for small and medium-sized organizations (ITSAP.00.070)](https://www.cyber.gc.ca/en/guidance/supply-chain-security-small-and-medium-sized-organizations-itsap00070) | [Family 17](../controls/17-supply-chain-risk-management.md), supply chain risk management |
| [Protect your organization from malware (ITSAP.00.057)](https://www.cyber.gc.ca/en/guidance/protect-your-organization-malware-itsap00057) | [`03.14.02`](../controls/14-system-and-information-integrity.md) malicious code protection |

Which bodies do what: Public Services and Procurement Canada leads the program and runs certification. National Defence shapes the requirements and performs Level 3 assessments. The Standards Council of Canada accredits the Level 2 certification bodies. The Cyber Centre wrote ITSP.10.171. Treasury Board Secretariat owns the policy framework, Innovation, Science and Economic Development Canada handles industry readiness, Global Affairs Canada covers allied-market access, and Public Safety Canada ties the program to the National Cyber Security Strategy.
