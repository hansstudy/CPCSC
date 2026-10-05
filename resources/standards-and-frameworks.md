# Standards and frameworks

| Document | What it is |
|---|---|
| [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171) | The Cyber Centre's Canadian version of NIST SP 800-171 Revision 3. 98 requirements in 17 families. First release April 2, 2025; second release October 28, 2025 (current). |
| [NIST SP 800-171 Rev 3](https://csrc.nist.gov/pubs/sp/800/171/r3/final) | The US document ITSP.10.171 adapts. Restructured to 97 requirements: duplicates consolidated, 3 families added (planning, system and services acquisition, supply chain risk management), organization-defined parameters introduced. |
| [NIST SP 800-171 Rev 2](https://csrc.nist.gov/pubs/sp/800/171/r2/upd1/final) | 110 requirements for controlled unclassified information on non-federal systems. What CMMC assesses. |
| [NIST SP 800-171A Rev 3](https://csrc.nist.gov/pubs/sp/800/171/a/r3/final) | Assessment procedures: determination statements and the 3 methods (examine, interview, test). PSPC's Level 1 criteria are a Canadian version. |
| [NIST SP 800-172](https://csrc.nist.gov/pubs/sp/800/172/final) | Enhanced requirements. CPCSC Level 3's additional controls are adapted from it. |
| [NIST SP 800-53 Rev 5](https://csrc.nist.gov/pubs/sp/800/53/r5/upd1/final) | The full US federal control catalogue. Canada's adaptation is ITSP.10.033, the security and privacy controls and assurance activities catalogue, and ITSP.10.171 aligns to it. |
| [NIST OLIR](https://csrc.nist.gov/projects/olir) | The program that publishes official crosswalks between NIST documents. Use it for the Rev 2 to Rev 3 mapping when you map CMMC evidence onto ITSP.10.171. |

## Identifiers

ITSP.10.171 keeps the Rev 3 identifiers (`03.FF.RR`, family then requirement). Identifiers NIST withdrew in Rev 3 stay in the Canadian numbering as "not allocated," so `03.05.03` in a Canadian document and in a NIST one refer to the same requirement. The one addition is `03.14.09`, the dedicated administration workstation, from Canada's own control catalogue (source control SI-400).

Rev 2 identifiers look different (`3.5.3`), and Rev 2 to Rev 3 isn't one-to-one: some Rev 2 requirements merged into one Rev 3 requirement, a few moved families, and some were withdrawn. The [Level 1 crosswalk](../controls/level-1-crosswalk.md) shows the mapping for the 13 Level 1 requirements.

## Organization-defined parameters

Rev 3, and so ITSP.10.171, leaves many values to the organization: the inactivity period before an account is disabled, failed logons before lockout, log retention, patch windows. Unless a contract names a value, you choose it, record it in your system security plan, and defend it at assessment. Annex B of ITSP.10.171 lists them. The [audit script](../scripts/) takes these values as parameters for that reason, and the [gap register](../templates/gap-register.csv) has a column for them.

## Machine-readable data

- [`data/itsp-10-171-requirements.json`](../data/itsp-10-171-requirements.json) and [`.csv`](../data/itsp-10-171-requirements.csv): all 98 requirements by family, with the Level 1 flag
- [`data/level-1-crosswalk.csv`](../data/level-1-crosswalk.csv): the Level 1 requirements against Rev 2 and CMMC Level 1
