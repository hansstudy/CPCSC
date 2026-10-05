# 01 Access control

16 requirements, 4 at Level 1. The right people reach the right data and nothing more.

What a first assessment tends to find: Everyone in the "Engineering" group can reach everything Engineering ever made, 3 departed employees still have live accounts, and the shared "shop floor" login has been running since 2019.

The work: Least privilege applied to the enclave. Role-based groups scoped to need, a joiner-mover-leaver process that fires the day someone changes roles, no shared accounts touching Specified Information, and remote access that terminates on the enclave's edge under MFA. Quarterly access reviews with a dated record turn this family from a hope into evidence.

Templates for this family:

- [Access control policy](https://hans.study/cpcsc/templates/access-control-policy/)
- [Build "Access control policy" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-AC)
- [Access review record](https://hans.study/cpcsc/templates/access-review-record/)
- [Shared responsibility matrix](https://hans.study/cpcsc/templates/shared-responsibility-matrix/)

Full reading for the family on hans.study: [Access control](https://hans.study/cpcsc/requirements/access-control/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.01.01 Account management (Level 1)

Decide which kinds of accounts are allowed and which are banned, then create, change, disable, and remove them by a written process. Every account has an owner, group or role, and set privileges, and unused accounts get disabled on a schedule you define.

Evidence to keep: account list with owners and roles, disable and review dates, the account policy.

You set: time period, circumstances. Record each value in your system security plan.

Audit script: Checks the built-in Guest account and enabled local accounts idle past `-InactiveDays`.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.02 Access enforcement (Level 1)

Permissions on systems and shares that hold Specified Information are set and enforced by the system. Nobody gets access because nobody thought to remove it.

Evidence to keep: group permissions on Specified Information shares, dated screenshots, the access control policy.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.03 Information flow enforcement

Control where Specified Information can flow, both inside your systems and out to connected ones. Segmentation, mail rules, and data loss controls are typical ways to do it.

Evidence to keep: network and data-flow diagrams, firewall and mail flow rules, segmentation configuration.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.04 Separation of duties

Identify duties that no single person should hold alone, such as requesting and approving access, and set permissions so the split is enforced. In a small shop this often means a second person approves administrator changes.

Evidence to keep: list of separated duties, role definitions, approval records.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.05 Least privilege

People and processes get only the access their tasks need. Define who can use security functions, review privileges on a schedule, and remove or reassign what's no longer needed.

Evidence to keep: role-to-privilege matrix, privilege review records, removal tickets.

You set: security functions, security-relevant information, frequency. Record each value in your system security plan.

Audit script: Checks that User Account Control is on.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.06 Least privilege (privileged accounts)

Limit privileged accounts to named people or roles. Administrators use a separate non-privileged account for email and browsing, and administrative actions come from a dedicated, isolated workstation.

Evidence to keep: administrator list with approval, separate admin and daily accounts, privileged account policy.

You set: personnel or roles. Record each value in your system security plan.

Audit script: Lists local Administrators members for review (manual).

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.07 Least privilege (privileged functions)

Ordinary users can't run privileged functions, and every use of a privileged function is logged. User Account Control, sudo policies, and audit logging usually cover it.

Evidence to keep: privileged function audit settings, sample log entries, local administrator restrictions.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.07) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.08 Unsuccessful logon attempts

Cap consecutive failed logons within a time window, and lock the account, delay the next prompt, or alert an administrator when the cap is hit. You choose the number and the response.

Evidence to keep: lockout policy export, the values recorded in your system security plan.

You set: number, time period. Record each value in your system security plan.

Audit script: Checks the lockout threshold against `-LockoutThreshold`.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.08) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.09 System use notification

Show a notice with the applicable security and privacy terms before anyone gets access. A logon banner does it.

Evidence to keep: banner text, screenshot of the logon screen, policy that approves the wording.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.09) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.10 Device lock

Lock the device after a period of inactivity, or require users to lock it before leaving. The lock stays until the person authenticates again, and the lock screen hides what was on the display.

Evidence to keep: inactivity limit policy, screenshot of the setting, the chosen timeout in your plan.

You set: time period. Record each value in your system security plan.

Audit script: Checks the machine inactivity lock or an enforced locking screen saver against `-ScreenLockSeconds`.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.10) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.11 Session termination

End a user session automatically on conditions you define, such as a period of inactivity or a policy event. Remote and web sessions are the usual targets.

Evidence to keep: session timeout settings for VPN, remote desktop, and web applications.

You set: conditions or trigger events requiring session disconnect. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.11) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.12 Remote access

Write down how each type of remote access may be used, authorize each type before it's used, and route it through managed access points. Remote execution of privileged commands needs its own authorization.

Evidence to keep: remote access policy, VPN and remote desktop configuration, authorization records.

Audit script: Checks Remote Desktop exposure and common third-party remote tools.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.12) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.16 Wireless access

Set rules for each kind of wireless access, authorize it before use, turn off wireless on devices that don't need it, and protect what remains with authentication and encryption.

Evidence to keep: wireless design and configuration, authentication method, list of authorized access points.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.16) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.18 Access control for mobile devices

Set rules for mobile devices, authorize them before they connect, and encrypt them, either the whole device or a container that holds Specified Information.

Evidence to keep: mobile device policy, enrolment list, encryption status report.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.18) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.20 Use of external systems (Level 1)

External systems, such as personal devices, a client's network, or a cloud service, are prohibited unless specifically authorized. When you authorize one, set the conditions it must meet first.

Evidence to keep: policy on personal and external systems, list of authorized external systems, agreements.

You set: security requirements. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.20) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.01.22 Publicly accessible content (Level 1)

Train the people who post to your website and social accounts so Specified Information doesn't end up there, and review public content periodically for anything that slipped through.

Evidence to keep: posting procedure, review records with dates, training record.

[hans.study reading](https://hans.study/cpcsc/requirements/access-control/#03.01.22) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

[All controls](README.md) · Next: [02 Awareness and training](02-awareness-and-training.md)
