# Controls: the 98 requirements of ITSP.10.171

Every requirement, in plain language, with the evidence to keep, the values you'll need to set, the audit script check where one exists, and links to the standard and to the matching reading on hans.study. The 13 Level 1 requirements are marked.

The standard's wording for each requirement is in [ITSP.10.171](https://www.cyber.gc.ca/en/guidance/protecting-specified-information-non-government-canada-systems-and-organizations-itsp10171). The descriptions here are plain-language readings, not a substitute for the standard.

## Families

| Code | Family | Requirements | At Level 1 |
|---|---|---|---|
| 01 | [Access control](01-access-control.md) | 16 | 4 |
| 02 | [Awareness and training](02-awareness-and-training.md) | 2 |  |
| 03 | [Audit and accountability](03-audit-and-accountability.md) | 8 |  |
| 04 | [Configuration management](04-configuration-management.md) | 10 |  |
| 05 | [Identification and authentication](05-identification-and-authentication.md) | 8 | 3 |
| 06 | [Incident response](06-incident-response.md) | 5 |  |
| 07 | [Maintenance](07-maintenance.md) | 3 |  |
| 08 | [Media protection](08-media-protection.md) | 7 | 1 |
| 09 | [Personnel security](09-personnel-security.md) | 2 |  |
| 10 | [Physical protection](10-physical-protection.md) | 5 | 2 |
| 11 | [Risk assessment](11-risk-assessment.md) | 3 |  |
| 12 | [Security assessment and monitoring](12-security-assessment-and-monitoring.md) | 4 |  |
| 13 | [System and communications protection](13-system-and-communications-protection.md) | 10 | 1 |
| 14 | [System and information integrity](14-system-and-information-integrity.md) | 6 | 2 |
| 15 | [Planning](15-planning.md) | 3 |  |
| 16 | [System and services acquisition](16-system-and-services-acquisition.md) | 3 |  |
| 17 | [Supply chain risk management](17-supply-chain-risk-management.md) | 3 |  |

## Level 1

- [Level 1 checklist](level-1-checklist.md): the 13 requirements with the evidence to keep and the filing steps
- [Level 1 crosswalk](level-1-crosswalk.md): the 13 against NIST SP 800-171 Rev 3 and Rev 2 and CMMC Level 1

## All 98

| ID | Requirement | Level 1 | Script |
|---|---|---|---|
| [`03.01.01`](01-access-control.md#030101-account-management-level-1) | Account management | Level 1 | yes |
| [`03.01.02`](01-access-control.md#030102-access-enforcement-level-1) | Access enforcement | Level 1 |  |
| [`03.01.03`](01-access-control.md#030103-information-flow-enforcement) | Information flow enforcement |  |  |
| [`03.01.04`](01-access-control.md#030104-separation-of-duties) | Separation of duties |  |  |
| [`03.01.05`](01-access-control.md#030105-least-privilege) | Least privilege |  | yes |
| [`03.01.06`](01-access-control.md#030106-least-privilege-privileged-accounts) | Least privilege (privileged accounts) |  | manual |
| [`03.01.07`](01-access-control.md#030107-least-privilege-privileged-functions) | Least privilege (privileged functions) |  |  |
| [`03.01.08`](01-access-control.md#030108-unsuccessful-logon-attempts) | Unsuccessful logon attempts |  | yes |
| [`03.01.09`](01-access-control.md#030109-system-use-notification) | System use notification |  |  |
| [`03.01.10`](01-access-control.md#030110-device-lock) | Device lock |  | yes |
| [`03.01.11`](01-access-control.md#030111-session-termination) | Session termination |  |  |
| [`03.01.12`](01-access-control.md#030112-remote-access) | Remote access |  | yes |
| [`03.01.16`](01-access-control.md#030116-wireless-access) | Wireless access |  |  |
| [`03.01.18`](01-access-control.md#030118-access-control-for-mobile-devices) | Access control for mobile devices |  |  |
| [`03.01.20`](01-access-control.md#030120-use-of-external-systems-level-1) | Use of external systems | Level 1 |  |
| [`03.01.22`](01-access-control.md#030122-publicly-accessible-content-level-1) | Publicly accessible content | Level 1 |  |
| [`03.02.01`](02-awareness-and-training.md#030201-literacy-training-and-awareness) | Literacy training and awareness |  |  |
| [`03.02.02`](02-awareness-and-training.md#030202-role-based-training) | Role-based training |  |  |
| [`03.03.01`](03-audit-and-accountability.md#030301-event-logging) | Event logging |  | yes |
| [`03.03.02`](03-audit-and-accountability.md#030302-audit-record-content) | Audit record content |  |  |
| [`03.03.03`](03-audit-and-accountability.md#030303-audit-record-generation) | Audit record generation |  |  |
| [`03.03.04`](03-audit-and-accountability.md#030304-response-to-audit-logging-process-failures) | Response to audit logging process failures |  |  |
| [`03.03.05`](03-audit-and-accountability.md#030305-audit-record-review-analysis-and-reporting) | Audit record review, analysis, and reporting |  |  |
| [`03.03.06`](03-audit-and-accountability.md#030306-audit-record-reduction-and-report-generation) | Audit record reduction and report generation |  |  |
| [`03.03.07`](03-audit-and-accountability.md#030307-time-stamps) | Time stamps |  | yes |
| [`03.03.08`](03-audit-and-accountability.md#030308-protection-of-audit-information) | Protection of audit information |  |  |
| [`03.04.01`](04-configuration-management.md#030401-baseline-configuration) | Baseline configuration |  |  |
| [`03.04.02`](04-configuration-management.md#030402-configuration-settings) | Configuration settings |  |  |
| [`03.04.03`](04-configuration-management.md#030403-configuration-change-control) | Configuration change control |  |  |
| [`03.04.04`](04-configuration-management.md#030404-impact-analyses) | Impact analyses |  |  |
| [`03.04.05`](04-configuration-management.md#030405-access-restrictions-for-change) | Access restrictions for change |  |  |
| [`03.04.06`](04-configuration-management.md#030406-least-functionality) | Least functionality |  | yes |
| [`03.04.08`](04-configuration-management.md#030408-authorized-software-allow-by-exception) | Authorized software (allow by exception) |  |  |
| [`03.04.10`](04-configuration-management.md#030410-system-component-inventory) | System component inventory |  |  |
| [`03.04.11`](04-configuration-management.md#030411-information-location) | Information location |  |  |
| [`03.04.12`](04-configuration-management.md#030412-system-and-component-configuration-for-high-risk-areas) | System and component configuration for high-risk areas |  |  |
| [`03.05.01`](05-identification-and-authentication.md#030501-user-identification-authentication-and-re-authentication-level-1) | User identification, authentication, and re-authentication | Level 1 |  |
| [`03.05.02`](05-identification-and-authentication.md#030502-device-identification-and-authentication-level-1) | Device identification and authentication | Level 1 |  |
| [`03.05.03`](05-identification-and-authentication.md#030503-multi-factor-authentication-level-1) | Multi-factor authentication | Level 1 | manual |
| [`03.05.04`](05-identification-and-authentication.md#030504-replay-resistant-authentication) | Replay-resistant authentication |  |  |
| [`03.05.05`](05-identification-and-authentication.md#030505-identifier-management) | Identifier management |  |  |
| [`03.05.07`](05-identification-and-authentication.md#030507-password-management) | Password management |  | yes |
| [`03.05.11`](05-identification-and-authentication.md#030511-authentication-feedback) | Authentication feedback |  |  |
| [`03.05.12`](05-identification-and-authentication.md#030512-authenticator-management) | Authenticator management |  |  |
| [`03.06.01`](06-incident-response.md#030601-incident-handling) | Incident handling |  |  |
| [`03.06.02`](06-incident-response.md#030602-incident-monitoring-reporting-and-response-assistance) | Incident monitoring, reporting, and response assistance |  |  |
| [`03.06.03`](06-incident-response.md#030603-incident-response-testing) | Incident response testing |  |  |
| [`03.06.04`](06-incident-response.md#030604-incident-response-training) | Incident response training |  |  |
| [`03.06.05`](06-incident-response.md#030605-incident-response-plan) | Incident response plan |  |  |
| [`03.07.04`](07-maintenance.md#030704-maintenance-tools) | Maintenance tools |  |  |
| [`03.07.05`](07-maintenance.md#030705-non-local-maintenance) | Non-local maintenance |  |  |
| [`03.07.06`](07-maintenance.md#030706-maintenance-personnel) | Maintenance personnel |  |  |
| [`03.08.01`](08-media-protection.md#030801-media-storage) | Media storage |  |  |
| [`03.08.02`](08-media-protection.md#030802-media-access) | Media access |  |  |
| [`03.08.03`](08-media-protection.md#030803-media-sanitization-level-1) | Media sanitization | Level 1 |  |
| [`03.08.04`](08-media-protection.md#030804-media-marking) | Media marking |  |  |
| [`03.08.05`](08-media-protection.md#030805-media-transport) | Media transport |  |  |
| [`03.08.07`](08-media-protection.md#030807-media-use) | Media use |  | yes |
| [`03.08.09`](08-media-protection.md#030809-system-backup-cryptographic-protection) | System backup (cryptographic protection) |  |  |
| [`03.09.01`](09-personnel-security.md#030901-personnel-screening) | Personnel screening |  |  |
| [`03.09.02`](09-personnel-security.md#030902-personnel-termination-and-transfer) | Personnel termination and transfer |  |  |
| [`03.10.01`](10-physical-protection.md#031001-physical-access-authorizations-level-1) | Physical access authorizations | Level 1 |  |
| [`03.10.02`](10-physical-protection.md#031002-monitoring-physical-access) | Monitoring physical access |  |  |
| [`03.10.06`](10-physical-protection.md#031006-alternate-work-site) | Alternate work site |  |  |
| [`03.10.07`](10-physical-protection.md#031007-physical-access-control-level-1) | Physical access control | Level 1 |  |
| [`03.10.08`](10-physical-protection.md#031008-access-control-for-transmission) | Access control for transmission |  |  |
| [`03.11.01`](11-risk-assessment.md#031101-risk-assessment) | Risk assessment |  |  |
| [`03.11.02`](11-risk-assessment.md#031102-vulnerability-monitoring-and-scanning) | Vulnerability monitoring and scanning |  |  |
| [`03.11.04`](11-risk-assessment.md#031104-risk-response) | Risk response |  |  |
| [`03.12.01`](12-security-assessment-and-monitoring.md#031201-security-assessment) | Security assessment |  |  |
| [`03.12.02`](12-security-assessment-and-monitoring.md#031202-plan-of-action-and-milestones) | Plan of action and milestones |  |  |
| [`03.12.03`](12-security-assessment-and-monitoring.md#031203-continuous-monitoring) | Continuous monitoring |  |  |
| [`03.12.05`](12-security-assessment-and-monitoring.md#031205-information-exchange) | Information exchange |  |  |
| [`03.13.01`](13-system-and-communications-protection.md#031301-boundary-protection-level-1) | Boundary protection | Level 1 | yes |
| [`03.13.04`](13-system-and-communications-protection.md#031304-information-in-shared-system-resources) | Information in shared system resources |  |  |
| [`03.13.06`](13-system-and-communications-protection.md#031306-network-communications-deny-by-default-allow-by-exception) | Network communications, deny by default, allow by exception |  |  |
| [`03.13.08`](13-system-and-communications-protection.md#031308-transmission-and-storage-confidentiality) | Transmission and storage confidentiality |  | yes |
| [`03.13.09`](13-system-and-communications-protection.md#031309-network-disconnect) | Network disconnect |  |  |
| [`03.13.10`](13-system-and-communications-protection.md#031310-cryptographic-key-establishment-and-management) | Cryptographic key establishment and management |  |  |
| [`03.13.11`](13-system-and-communications-protection.md#031311-cryptographic-protection) | Cryptographic protection |  | yes |
| [`03.13.12`](13-system-and-communications-protection.md#031312-collaborative-computing-devices-and-applications) | Collaborative computing devices and applications |  |  |
| [`03.13.13`](13-system-and-communications-protection.md#031313-mobile-code) | Mobile code |  |  |
| [`03.13.15`](13-system-and-communications-protection.md#031315-session-authenticity) | Session authenticity |  |  |
| [`03.14.01`](14-system-and-information-integrity.md#031401-flaw-remediation-level-1) | Flaw remediation | Level 1 | yes |
| [`03.14.02`](14-system-and-information-integrity.md#031402-malicious-code-protection-level-1) | Malicious code protection | Level 1 | yes |
| [`03.14.03`](14-system-and-information-integrity.md#031403-security-alerts-advisories-and-directives) | Security alerts, advisories, and directives |  |  |
| [`03.14.06`](14-system-and-information-integrity.md#031406-system-monitoring) | System monitoring |  |  |
| [`03.14.08`](14-system-and-information-integrity.md#031408-information-management-and-retention) | Information management and retention |  |  |
| [`03.14.09`](14-system-and-information-integrity.md#031409-dedicated-administration-workstation) | Dedicated administration workstation |  | manual |
| [`03.15.01`](15-planning.md#031501-policy-and-procedures) | Policy and procedures |  |  |
| [`03.15.02`](15-planning.md#031502-system-security-plan) | System security plan |  |  |
| [`03.15.03`](15-planning.md#031503-rules-of-behaviour) | Rules of behaviour |  |  |
| [`03.16.01`](16-system-and-services-acquisition.md#031601-security-engineering-principles) | Security engineering principles |  |  |
| [`03.16.02`](16-system-and-services-acquisition.md#031602-unsupported-system-components) | Unsupported system components |  |  |
| [`03.16.03`](16-system-and-services-acquisition.md#031603-external-system-services) | External system services |  |  |
| [`03.17.01`](17-supply-chain-risk-management.md#031701-supply-chain-risk-management-plan) | Supply chain risk management plan |  |  |
| [`03.17.02`](17-supply-chain-risk-management.md#031702-acquisition-strategies-tools-and-methods) | Acquisition strategies, tools, and methods |  |  |
| [`03.17.03`](17-supply-chain-risk-management.md#031703-supply-chain-requirements-and-processes) | Supply chain requirements and processes |  |  |

"Script" means the endpoint audit checks something for the requirement, or lists items for manual review. See [`scripts/`](../scripts/).

Identifiers match NIST SP 800-171 Rev 3. The ones NIST withdrew stay in the Canadian numbering as "not allocated," which is why the sequence has gaps. `03.14.09` is the one requirement Canada added.
