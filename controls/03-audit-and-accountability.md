# 03 Audit and accountability

8 requirements. When something happens, you can reconstruct it.

What a first assessment tends to find: Logs exist wherever vendors defaulted them on, retained until the disk fills, reviewed never.

The work: Decide which events matter (authentication, privilege use, access to the enclave, changes to security configuration), aggregate them somewhere central even if it's a modest syslog box, retain them for a defined period, protect them from tampering, and review them on a schedule a human keeps. An assessor asking for last Tuesday needs to get last Tuesday.

Templates for this family:

- [Policy inventory checklist](https://hans.study/cpcsc/templates/policy-inventory/)
- [Shared responsibility matrix](https://hans.study/cpcsc/templates/shared-responsibility-matrix/)

Full reading for the family on hans.study: [Audit and accountability](https://hans.study/cpcsc/requirements/audit-and-accountability/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.03.01 Event logging

Decide which events the systems log, write the list down, and revisit it on a schedule. Logons, account changes, privileged use, and policy changes are the usual core.

Evidence to keep: event types list, audit policy export, the review schedule.

You set: event types, frequency. Record each value in your system security plan.

Audit script: Checks key audit policy subcategories and Security log size; central collection is manual.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.02 Audit record content

Each log record says what happened, when, where, the source, the outcome, and who or what was involved. Add more fields when you need them.

Evidence to keep: sample log records showing each field.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.03 Audit record generation

Generate logs for the events you selected and keep them for the period your records policy sets.

Evidence to keep: retention setting, log storage evidence, the records retention policy.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.04 Response to audit logging process failures

Alert someone within a time you define when logging fails, and take any extra actions you've set. A silent logging failure is the case this is written for.

Evidence to keep: alert configuration, test of a logging failure, named recipients.

You set: time period, additional actions. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.05 Audit record review, analysis, and reporting

Review logs on a schedule for unusual or inappropriate activity, report what you find, and correlate across repositories so one system's logs don't sit alone.

Evidence to keep: dated review records, reports of findings, central log collector showing the hosts.

You set: frequency. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.06 Audit record reduction and report generation

Have a way to search, summarize, and report on logs that supports investigations after the fact, without changing the original records or their order.

Evidence to keep: log tool or SIEM screenshots, sample report, proof originals are preserved.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.07 Time stamps

Time-stamp records from the system clock, in UTC or with a fixed or recorded local offset, at a granularity you define. Clocks need to agree across systems for logs to line up.

Evidence to keep: time source configuration, granularity chosen, NTP settings across servers and devices.

You set: granularity of time measurement. Record each value in your system security plan.

Audit script: Checks that a time source is configured and not free-running.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.07) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.03.08 Protection of audit information

Protect logs and logging tools from unauthorized access, change, and deletion, and let only a small set of privileged people manage logging.

Evidence to keep: log permissions, list of people who can manage logging, write-once or remote storage evidence.

[hans.study reading](https://hans.study/cpcsc/requirements/audit-and-accountability/#03.03.08) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [02 Awareness and training](02-awareness-and-training.md) · [All controls](README.md) · Next: [04 Configuration management](04-configuration-management.md)
