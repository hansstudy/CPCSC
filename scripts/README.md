# Audit scripts

Two read-only PowerShell scripts. They change nothing on the machines they check.

| Script | What it does |
|---|---|
| `Invoke-CpcscEndpointAudit.ps1` | Audits one Windows machine against technical ITSP.10.171 requirements and writes HTML, JSON, and CSV reports |
| `Merge-CpcscAuditReports.ps1` | Reads a folder of those JSON reports (newest per machine) and writes a fleet summary: CSV, a check-by-machine matrix, and HTML |

Requirements: Windows 10 or 11, or Windows Server 2016 or later, with Windows PowerShell 5.1 or PowerShell 7. Run the endpoint audit elevated; without administrator rights the BitLocker, audit policy, security policy, and Security log checks report `ERROR`.

## Running it

```powershell
Unblock-File .\Invoke-CpcscEndpointAudit.ps1, .\Merge-CpcscAuditReports.ps1
.\Invoke-CpcscEndpointAudit.ps1 -OutputPath C:\CPCSC\evidence
```

If your execution policy still blocks it, for this session only: `Set-ExecutionPolicy -Scope Process Bypass`.

At scale, push the endpoint script with Intune, Group Policy, or your RMM, point `-OutputPath` at a share the machines can write to, and run the merge script against that share.

## Parameters (your organization-defined parameters)

| Parameter | Default | Requirement |
|---|---|---|
| `-InactiveDays` | 30 | `03.01.01` enabled local accounts idle longer than this are flagged |
| `-PatchDays` | 30 | `03.14.01` most recent successful update must be newer |
| `-SignatureMaxAgeDays` | 3 | `03.14.02` antivirus signature age |
| `-MinPasswordLength` | 14 | `03.05.07` minimum password length |
| `-LockoutThreshold` | 10 | `03.01.08` failed logons before lockout |
| `-ScreenLockSeconds` | 900 | `03.01.10` inactivity before the device locks |
| `-SecurityLogMinKB` | 196608 | `03.03.01` Security event log size |

Use the values written in your system security plan. The report records which values it used.

## What it checks

| ITSP.10.171 | Level | Rev 2 | Check |
|---|---|---|---|
| `03.01.01` Account management | 1 | 3.1.1 | Guest disabled; enabled local accounts idle past `-InactiveDays` |
| `03.01.05` Least privilege | 2 | 3.1.5 | User Account Control on |
| `03.01.06` Least privilege (privileged accounts) | 2 | 3.1.5, 3.1.6 | Local Administrators members listed for review (MANUAL) |
| `03.01.08` Unsuccessful logon attempts | 2 | 3.1.8 | Lockout threshold set and within `-LockoutThreshold` |
| `03.01.10` Device lock | 2 | 3.1.10 | Machine inactivity lock or enforced locking screen saver |
| `03.01.12` Remote access | 2 | 3.1.12 | RDP off, or on with NLA; common third-party remote tools installed |
| `03.03.01` Event logging | 2 | 3.3.1 | Core audit policy subcategories; Security log size; central collection (MANUAL) |
| `03.03.07` Time stamps | 2 | 3.3.7 | Time source configured and not free-running |
| `03.04.06` Least functionality | 2 | 3.4.6, 3.4.7 | SMBv1 server off; AutoRun off |
| `03.05.03` Multi-factor authentication | 1 | 3.5.3 | MANUAL: evidence lives in your identity provider |
| `03.05.07` Password management | 2 | 3.5.7 | Minimum password length |
| `03.08.07` Media use | 2 | 3.8.7 | Removable storage restricted by policy |
| `03.13.01` Boundary protection | 1 | 3.13.1, 3.13.5 | Windows Firewall on, inbound blocked by default, every profile |
| `03.13.08` Transmission and storage confidentiality | 2 | 3.13.8, 3.13.16 | BitLocker on and fully encrypted, every fixed volume |
| `03.13.11` Cryptographic protection | 2 | 3.13.11 | TLS 1.0 and 1.1 explicitly disabled |
| `03.14.01` Flaw remediation | 1 | 3.14.1 | Last successful update within `-PatchDays`; pending reboot |
| `03.14.02` Malicious code protection | 1 | 3.14.2, 3.14.4, 3.14.5 | Defender on with current signatures, or a registered third-party product |
| `03.14.09` Dedicated administration workstation | 2 | none | MANUAL: Canada's addition |

Statuses: `PASS`, `FAIL`, `WARN` (review it), `MANUAL` (needs evidence a script can't collect), `ERROR` (couldn't read; usually needs elevation).

## What it can't see

Policies, training, physical security, MFA on cloud and VPN services, network firewalls, central logging, where administration actually happens, and anything on non-Windows systems. A clean report is evidence for one machine's settings. It isn't a CPCSC attestation, a certification, or an assessment.

Checks that read `auditpol` and `w32tm` output expect English-language Windows and can misreport on other display languages. The Rev 2 and CMMC mappings are approximate; confirm against NIST's official Rev 2 to Rev 3 crosswalk before using them in an assessment.

## Tested

CI parses both scripts, runs PSScriptAnalyzer, merges the synthetic reports in `samples/`, and runs the endpoint audit on a Windows runner. `tests/Test-EndpointAudit.ps1` runs the audit against stubbed Windows commands on any OS. The endpoint checks use built-in Windows cmdlets and registry locations; if a check misbehaves on your build, please [open an issue](../../../issues/new/choose) with the Windows version and the report's JSON entry.
