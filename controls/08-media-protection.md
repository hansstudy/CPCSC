# 08 Media protection

7 requirements, 1 at Level 1. Protected data on removable and portable media is controlled from creation to destruction.

What a first assessment tends to find: USB sticks with engineering data in every drawer, and dead drives in a box under the bench.

The work: Encrypt what moves, sanitize what leaves to a recognized method (ITSP.40.006 is the Canadian guidance; NIST SP 800-88 is the American one), destroy what dies, and keep the receipts. The USB stick culture around engineering data either ends or gets managed with encrypted, inventoried drives.

Templates for this family:

- [Media handling policy and sanitization log](https://hans.study/cpcsc/templates/media-handling/)
- [Build "Media handling policy and sanitization log" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-MP)

Full reading for the family on hans.study: [Media protection](https://hans.study/cpcsc/requirements/media-protection/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.08.01 Media storage

Physically control and securely store media that holds Specified Information, including drives, backup media, and paper.

Evidence to keep: media storage procedure, locked storage evidence, media inventory.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.02 Media access

Only authorized people or roles can reach Specified Information on media.

Evidence to keep: media access list, permissions on storage areas.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.03 Media sanitization (Level 1)

Sanitize media that held Specified Information before it's disposed of, leaves your control, or is reused. Keep a record of the method.

Evidence to keep: sanitization and destruction log with method and date, certificates from vendors.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.04 Media marking

Mark media with distribution limits, handling caveats, and the applicable Specified Information markings.

Evidence to keep: marking standard, photos or samples of marked media.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.05 Media transport

Protect and account for media that goes outside controlled areas, and document the transport. Couriers, mailing drives, and carrying laptops are in scope.

Evidence to keep: transport procedure, chain of custody or shipping records.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.07 Media use

Restrict or prohibit the media types you've listed, and prohibit removable media that has no identifiable owner. USB policy is the usual way in.

Evidence to keep: removable media policy, endpoint control configuration, approved device list.

You set: types of system media. Record each value in your system security plan.

Audit script: Checks for a removable storage restriction policy.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.07) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.08.09 System backup (cryptographic protection)

Encrypt backups so Specified Information isn't exposed at backup storage locations.

Evidence to keep: backup encryption settings, key handling for backup sets.

[hans.study reading](https://hans.study/cpcsc/requirements/media-protection/#03.08.09) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [07 Maintenance](07-maintenance.md) · [All controls](README.md) · Next: [09 Personnel security](09-personnel-security.md)
