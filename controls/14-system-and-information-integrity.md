# 14 System and information integrity

6 requirements, 2 at Level 1. Patch on a cadence with proof, run current malware protection everywhere in scope, act on the alerts your own tools raise, and do administrative work only from a dedicated, isolated workstation.

What a first assessment tends to find: "we patch when we can," Windows patched and nothing else, alerts landing in a mailbox nobody owns.

The work: "critical patches inside 14 days, the rest monthly, exceptions recorded," with the patch report joining the evidence folder and every alert routed to a ticket that gets closed.

Templates for this family:

- [Change management policy and change request record](https://hans.study/cpcsc/templates/change-management/)
- [Build "Change management policy and change request record" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-CM)
- [Backup policy paragraph and restore test log](https://hans.study/cpcsc/templates/backup-and-restore-test/)
- [Build "Backup policy paragraph and restore test log" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-BR)

Full reading for the family on hans.study: [System and information integrity](https://hans.study/cpcsc/requirements/system-and-information-integrity/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.14.01 Flaw remediation (Level 1)

Identify, report, and correct flaws, and install security-relevant software and firmware updates within a time you define after release. Keep proof.

Evidence to keep: patch window in policy, patch reports, evidence of installed updates.

You set: time period. Record each value in your system security plan.

Audit script: Checks the last successful OS or software update against `-PatchDays`, ignoring definition updates, and any pending reboot.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.14.02 Malicious code protection (Level 1)

Run malicious code protection at system entry and exit points, keep it current, and configure it to scan on a schedule and in real time as files are opened or downloaded.

Evidence to keep: endpoint console showing current, scanning, and blocking, plus the update configuration.

You set: frequency. Record each value in your system security plan.

Audit script: Checks Defender (normal mode, current signatures) or a registered third-party product.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.14.03 Security alerts, advisories, and directives

Receive security alerts and advisories from outside organizations on an ongoing basis, and issue internal ones when needed. A subscription to the Cyber Centre's alerts is a start.

Evidence to keep: alert subscriptions, internal advisory examples, response records.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.14.06 System monitoring

Monitor the system to detect attacks and indicators of attacks, unauthorized connections, and unauthorized use, and watch inbound and outbound traffic for unusual activity.

Evidence to keep: monitoring tool configuration, alert samples, review records.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.14.08 Information management and retention

Manage and retain Specified Information and output from your systems according to the laws, directives, and policies that apply.

Evidence to keep: records retention schedule, disposal procedure.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.08) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.14.09 Dedicated administration workstation

Do administrative and superuser work only from a dedicated, hardened physical workstation isolated from other functions and from the internet. Remote connections use a carrier private network, such as VPLS or MPLS, with VPN encryption. Canada added this requirement to the NIST set.

Evidence to keep: list of administration workstations, hardening configuration, diagram of the paths they use.

Audit script: Manual item: a script on one endpoint can't show where administration happens.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-information-integrity/#03.14.09) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [13 System and communications protection](13-system-and-communications-protection.md) · [All controls](README.md) · Next: [15 Planning](15-planning.md)
