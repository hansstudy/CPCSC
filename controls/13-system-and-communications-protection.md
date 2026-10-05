# 13 System and communications protection

10 requirements, 1 at Level 1. The network architecture itself defends the data.

What a first assessment tends to find: One flat subnet behind a consumer router, and a guest wifi that is a different SSID and nothing else.

The work: A real boundary with deny-by-default rules at the edge, encryption for Specified Information in transit and wherever it's stored, which  03.13.08  requires on servers, laptops, backups, and portable media alike, separation between the enclave and everything else that isn't just a different SSID, and DNS and remote access paths you can draw. If your firewall rule set can't be explained to an assessor in one sitting, it can't be defended in one either.

Templates for this family:

- [System security plan outline](https://hans.study/cpcsc/templates/system-security-plan-outline/)
- [Level 1 requirements and evidence checklist](https://hans.study/cpcsc/templates/level-1-checklist/)

Full reading for the family on hans.study: [System and communications protection](https://hans.study/cpcsc/requirements/system-and-communications-protection/). The standard's own text for every requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171).

## 03.13.01 Boundary protection (Level 1)

Monitor and control traffic at the outer boundary and key internal boundaries, put public-facing components on separate subnetworks, and connect to outside systems only through managed interfaces.

Evidence to keep: firewall rule set, managed interface list, segmentation diagram.

Audit script: Checks Windows Firewall is on with inbound blocked by default, on every profile.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.01) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.04 Information in shared system resources

Prevent information from leaking between users or processes through shared resources, such as reused memory or storage.

Evidence to keep: platform documentation, configuration of virtualization or storage isolation.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.04) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.06 Network communications, deny by default, allow by exception

Block network traffic by default and permit only what you've approved.

Evidence to keep: default-deny rules on firewalls, rule review records.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.06) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.08 Transmission and storage confidentiality

Use cryptography to prevent unauthorized disclosure of Specified Information in transit and at rest. Full-disk encryption and TLS are the usual measures.

Evidence to keep: disk encryption status, TLS configuration, encryption policy.

Audit script: Checks BitLocker is on and fully encrypted on every fixed volume.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.08) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.09 Network disconnect

End network connections when the session ends or after an inactivity period you define.

Evidence to keep: idle timeout settings for VPN, firewall, and remote sessions.

You set: time period. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.09) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.10 Cryptographic key establishment and management

Generate, distribute, store, access, and destroy cryptographic keys under requirements you define.

Evidence to keep: key management procedure, key storage evidence, access list.

You set: requirements for key generation, distribution, storage, access, and destruction. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.10) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.11 Cryptographic protection

Use the types of cryptography you've specified when protecting Specified Information, and record which ones. Approved algorithms and protocol versions belong in that list.

Evidence to keep: cryptographic standard with chosen types, TLS and cipher configuration.

You set: types of cryptography. Record each value in your system security plan.

Audit script: Checks that TLS 1.0 and 1.1 are explicitly disabled.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.11) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.12 Collaborative computing devices and applications

Prohibit remote activation of cameras and microphones on conferencing and collaboration devices, with defined exceptions, and give a visible sign when they're in use.

Evidence to keep: collaboration device policy, configuration disabling remote activation.

You set: exceptions where remote activation is to be allowed. Record each value in your system security plan.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.12) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.13 Mobile code

Define acceptable mobile code, such as scripts and macros, and authorize, monitor, and control its use.

Evidence to keep: macro and script policy, configuration blocking or restricting mobile code.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.13) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

## 03.13.15 Session authenticity

Protect the authenticity of communication sessions, so a session can't be hijacked or spoofed.

Evidence to keep: TLS and session protection settings, certificate management.

[hans.study reading](https://hans.study/cpcsc/requirements/system-and-communications-protection/#03.13.15) · [ITSP.10.171 text](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171)

- [ ] Met, with evidence filed

Previous: [12 Security assessment and monitoring](12-security-assessment-and-monitoring.md) · [All controls](README.md) · Next: [14 System and information integrity](14-system-and-information-integrity.md)
