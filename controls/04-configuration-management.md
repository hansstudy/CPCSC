# 04 Configuration management

10 requirements. Systems run in a known state and change on purpose.

What a first assessment tends to find: Golden images from 3 IT generations ago, local admin everywhere, and change control that lives in someone's memory.

The work: Baselines for the enclave's workstation and server classes, hardened against a recognized benchmark, local admin stripped from daily-driver accounts, an inventory of what runs, and every change recorded with a date and a name. Tedious, and it powers half the other families, because drift is where controls stop working without anyone noticing.

Templates for this family:

- [Change management policy and change request record](https://hans.study/cpcsc/templates/change-management/)
- [Build "Change management policy and change request record" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-CM)

Full reading for the family on hans.study: [Configuration management](https://hans.study/cpcsc/requirements/configuration-management/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.04.01 Baseline configuration

Keep a current, controlled baseline configuration for each system, and update it on a schedule and whenever components change.

Evidence to keep: baseline documents or configuration templates, version history, review records.

You set: frequency. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.02 Configuration settings

Set and document the most restrictive configuration that still lets the work happen, apply it, and record and approve any deviation.

Evidence to keep: hardening standards, configuration exports, approved deviations.

You set: configuration settings. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.03 Configuration change control

Define which changes are configuration-controlled, review and approve them with security in mind, document what was done, and monitor the process.

Evidence to keep: change management policy, change request records with approvals.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.04 Impact analyses

Analyze the security effect of a change before making it, and confirm the requirements still hold afterward.

Evidence to keep: impact analysis section of change records, post-change checks.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.05 Access restrictions for change

Define and enforce who may make changes to systems, both physically and logically. Administrative rights over production are the main target.

Evidence to keep: list of people with change rights, permissions evidence, approval path.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.06 Least functionality

Run only the functions the work needs. Disable or restrict the ports, protocols, services, and features you've listed as unnecessary or unsafe, and review the system on a schedule to find more.

Evidence to keep: prohibited and restricted list, service and port review, hardening configuration.

You set: functions, ports, protocols, connections, and services, frequency. Record each value in your system security plan.

Audit script: Checks that the SMBv1 server and AutoRun are off.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.08 Authorized software (allow by exception)

Decide which software may run, deny everything else by default, and review the allow list on a schedule. Application control tools do the enforcing.

Evidence to keep: authorized software list, application control policy, review records.

You set: frequency. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.08) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.10 System component inventory

Keep an inventory of system components, review it on a schedule, and update it when things are installed, removed, or updated.

Evidence to keep: asset inventory with owners and locations, update procedure, review dates.

You set: frequency. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.10) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.11 Information location

Know and document where Specified Information is processed and stored, and which components hold it. Record changes to those locations.

Evidence to keep: data location map, component list for the boundary, change records.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.11) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.04.12 System and component configuration for high-risk areas

Issue travelers to high-risk locations with specific configurations, such as clean loaner laptops, and apply defined measures when they return.

Evidence to keep: travel policy, loaner configuration, return checklist.

You set: system configurations, security requirements. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/configuration-management/#03.04.12) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [03 Audit and accountability](03-audit-and-accountability.md) · [All controls](README.md) · Next: [05 Identification and authentication](05-identification-and-authentication.md)
