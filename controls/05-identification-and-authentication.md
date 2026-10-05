# 05 Identification and authentication

8 requirements, 3 at Level 1. Know who is on the system before it does anything.

What a first assessment tends to find: MFA on the VPN maybe, absent on email, absent on the domain, absent on the cloud tenant's admin plane.

The work: MFA on every path to Specified Information and on every privileged account, unique IDs, a written password policy that matches the one applied, and replay-resistant mechanisms. At Level 2 none of this is negotiable, and it shouldn't be at your company regardless of the program.

Templates for this family:

- [Password and authentication policy](https://hans.study/cpcsc/templates/password-authentication-policy/)
- [Build "Password and authentication policy" in the policy builder](https://hans.study/tools/policy-builder/?profile=cpcsc&policy=POL-IA)

Full reading for the family on hans.study: [Identification and authentication](https://hans.study/cpcsc/requirements/identification-and-authentication/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.05.01 User identification, authentication, and re-authentication (Level 1)

Every user has a unique identity tied to the processes acting for them, and users re-authenticate in circumstances you define. No shared logins.

Evidence to keep: list of unique user IDs, shared account check, re-authentication settings.

You set: circumstances or situations requiring re-authentication. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.02 Device identification and authentication (Level 1)

Uniquely identify and authenticate the devices you've chosen before they connect. 802.1X, certificates, or a managed device list are common approaches.

Evidence to keep: device inventory, 802.1X or certificate configuration, the device types you chose.

You set: devices or types of devices. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.02) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.03 Multi-factor authentication (Level 1)

Strong multi-factor authentication for privileged and non-privileged accounts. This is the Level 1 requirement CMMC Level 1 doesn't have.

Evidence to keep: MFA policy, conditional access or MFA configuration, enrolment report covering every account.

Audit script: Manual item: the evidence lives in your identity provider.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.03) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.04 Replay-resistant authentication

Use authentication that can't be defeated by replaying captured traffic, for privileged and non-privileged accounts. Modern MFA and protocols such as Kerberos or TLS-bound tokens provide it.

Evidence to keep: authentication protocol settings, vendor documentation for the MFA method.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.05 Identifier management

Get authorization before issuing an identifier to a person, group, role, service, or device. Assign it uniquely, don't reuse it for a period you define, and mark individuals' identifiers by status.

Evidence to keep: identifier assignment procedure, reuse period, account naming standard.

You set: time period, characteristic identifying individual status. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.05) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.07 Password management

Screen new passwords against a list of common and compromised ones, send passwords only over encrypted channels, store them hashed and salted, and force an immediate change on temporary passwords.

Evidence to keep: password policy, breached-password screening configuration, length and complexity settings.

You set: frequency, composition and complexity rules. Record each value in your system security plan.

Audit script: Checks minimum password length against `-MinPasswordLength`.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.07) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.11 Authentication feedback

Don't echo authentication secrets as people type them. Password fields that mask input satisfy it.

Evidence to keep: screenshots of masked input on logon forms.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.11) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.05.12 Authenticator management

Manage authenticators through their lifecycle: verify the recipient at issue, set initial content, handle lost, damaged, or compromised ones, change defaults, and protect them. Hardware keys, tokens, and certificates all count.

Evidence to keep: authenticator issuing procedure, default credential change records, lost token handling.

You set: frequency, events. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/identification-and-authentication/#03.05.12) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [04 Configuration management](04-configuration-management.md) · [All controls](README.md) · Next: [06 Incident response](06-incident-response.md)
