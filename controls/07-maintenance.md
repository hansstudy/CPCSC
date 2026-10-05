# 07 Maintenance

3 requirements. Control who services the systems, with what tools, from where.

What a first assessment tends to find: The MSP's whole bench has a remote tool on every machine, and the photocopier technician has had a network drop for years.

The work: Scope who may service what, route remote access through a jump host, record support sessions, and sanitize equipment before it leaves for repair. Your photocopier tech and your MSP both count.

Templates for this family:

- [Shared responsibility matrix](https://hans.study/cpcsc/templates/shared-responsibility-matrix/)
- [Change management policy and change request record](https://hans.study/cpcsc/templates/change-management/)
- [Build "Change management policy and change request record" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-CM)

Full reading for the family on hans.study: [Maintenance](https://hans.study/cpcsc/requirements/maintenance/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.07.04 Maintenance tools

Approve, control, and monitor maintenance tools, scan diagnostic media for malicious code before use, and keep maintenance equipment that holds Specified Information from leaving without sanitizing it or confirming it's clean.

Evidence to keep: approved tool list, media scan records, equipment removal log.

[hans.study reading](https://hans.study/cpcsc/requirements/maintenance/#03.07.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.07.05 Non-local maintenance

Approve and monitor remote maintenance, require MFA and replay resistance to start the session, and end the session and connections when work is done. Vendor remote support sessions fall under this.

Evidence to keep: remote maintenance procedure, MFA on vendor access, session logs.

[hans.study reading](https://hans.study/cpcsc/requirements/maintenance/#03.07.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.07.06 Maintenance personnel

Authorize maintenance personnel and keep a list of them. Unescorted people need the right access authorizations, and someone qualified supervises those who don't have them.

Evidence to keep: authorized maintenance personnel and organizations list, escort records.

[hans.study reading](https://hans.study/cpcsc/requirements/maintenance/#03.07.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [06 Incident response](06-incident-response.md) · [All controls](README.md) · Next: [08 Media protection](08-media-protection.md)
