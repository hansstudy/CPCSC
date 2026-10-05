#Requires -Version 5.1
<#
.SYNOPSIS
    Read-only Windows endpoint audit for the technical ITSP.10.171 requirements behind CPCSC.

.DESCRIPTION
    Checks one Windows machine against technical requirements in ITSP.10.171 (the standard behind
    Canada's CPCSC program), each mapped to NIST SP 800-171 Rev 3 (same identifiers), the nearest
    NIST SP 800-171 Rev 2 requirements, and the CMMC level those Rev 2 requirements sit at.

    The script changes nothing on the machine. It reads settings and writes a report (JSON, CSV,
    and HTML) to -OutputPath.

    It covers settings a script can see. Many requirements (policies, training, physical security,
    MFA on cloud services, the dedicated admin workstation) need evidence a script can't collect;
    those appear in the report as MANUAL items so they aren't forgotten.

    A PASS here is evidence for one machine. It is not a CPCSC attestation or certification.

.PARAMETER OutputPath
    Folder for the report files. Created if missing. Default: .\reports

.PARAMETER InactiveDays
    Organization-defined parameter for 03.01.01: enabled local accounts unused for longer than this are flagged. Default 30.

.PARAMETER PatchDays
    Organization-defined parameter for 03.14.01: the most recent successful update must be newer than this. Default 30.

.PARAMETER SignatureMaxAgeDays
    For 03.14.02: maximum age of antivirus signatures. Default 3.

.PARAMETER MinPasswordLength
    Organization-defined parameter for 03.05.07. Default 14.

.PARAMETER LockoutThreshold
    Organization-defined parameter for 03.01.08: maximum failed attempts before lockout. Default 10.

.PARAMETER ScreenLockSeconds
    Organization-defined parameter for 03.01.10: maximum inactivity before the device locks. Default 900.

.PARAMETER SecurityLogMinKB
    For 03.03.01: minimum Security event log size in KB. Default 196608 (192 MB).

.PARAMETER NoHtml
    Skip the HTML report.

.EXAMPLE
    .\Invoke-CpcscEndpointAudit.ps1
    Run with the defaults from an elevated PowerShell prompt.

.EXAMPLE
    .\Invoke-CpcscEndpointAudit.ps1 -OutputPath C:\CPCSC\evidence -InactiveDays 45 -PatchDays 14
    Use your own organization-defined parameters, as recorded in your system security plan.

.NOTES
    Project : cpcsc-itsp-10-171-readiness
    Author  : Hans Study, hans.study
    License : MIT
    Run elevated for complete results. Several checks (BitLocker, audit policy, security policy
    export, Security log) need administrator rights and report ERROR without them.
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Console summary for an interactive tool; results go to the report files.')]
[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path -Path (Get-Location) -ChildPath 'reports'),
    [ValidateRange(1, 3650)][int]$InactiveDays = 30,
    [ValidateRange(1, 365)][int]$PatchDays = 30,
    [ValidateRange(1, 90)][int]$SignatureMaxAgeDays = 3,
    [ValidateRange(8, 128)][int]$MinPasswordLength = 14,
    [ValidateRange(1, 999)][int]$LockoutThreshold = 10,
    [ValidateRange(60, 86400)][int]$ScreenLockSeconds = 900,
    [ValidateRange(20480, 4194304)][int]$SecurityLogMinKB = 196608,
    [switch]$NoHtml
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$ScriptVersion = '1.0.0'

# ---------------------------------------------------------------------------------------------
# Requirement map. ITSP.10.171 identifiers match NIST SP 800-171 Rev 3. Rev 2 mappings are the
# nearest Rev 2 requirements; CMMC level follows the Rev 2 requirement (Level 1 = the 15 FAR
# 52.204-21 requirements, Level 2 = the 110). Confirm against NIST's official Rev 2 to Rev 3
# crosswalk before relying on any mapping in an assessment.
# ---------------------------------------------------------------------------------------------
$Map = @{
    '03.01.01' = @{ Title = 'Account management'; Family = 'Access Control'; CpcscLevel = 1; R2 = '3.1.1'; Cmmc = 'L1 (FAR 52.204-21 b.1.i)' }
    '03.01.05' = @{ Title = 'Least privilege'; Family = 'Access Control'; CpcscLevel = 2; R2 = '3.1.5'; Cmmc = 'AC.L2-3.1.5' }
    '03.01.06' = @{ Title = 'Least privilege (privileged accounts)'; Family = 'Access Control'; CpcscLevel = 2; R2 = '3.1.5, 3.1.6'; Cmmc = 'AC.L2-3.1.5, AC.L2-3.1.6' }
    '03.01.08' = @{ Title = 'Unsuccessful logon attempts'; Family = 'Access Control'; CpcscLevel = 2; R2 = '3.1.8'; Cmmc = 'AC.L2-3.1.8' }
    '03.01.10' = @{ Title = 'Device lock'; Family = 'Access Control'; CpcscLevel = 2; R2 = '3.1.10'; Cmmc = 'AC.L2-3.1.10' }
    '03.01.12' = @{ Title = 'Remote access'; Family = 'Access Control'; CpcscLevel = 2; R2 = '3.1.12'; Cmmc = 'AC.L2-3.1.12' }
    '03.03.01' = @{ Title = 'Event logging'; Family = 'Audit and Accountability'; CpcscLevel = 2; R2 = '3.3.1'; Cmmc = 'AU.L2-3.3.1' }
    '03.03.07' = @{ Title = 'Time stamps'; Family = 'Audit and Accountability'; CpcscLevel = 2; R2 = '3.3.7'; Cmmc = 'AU.L2-3.3.7' }
    '03.04.06' = @{ Title = 'Least functionality'; Family = 'Configuration Management'; CpcscLevel = 2; R2 = '3.4.6, 3.4.7'; Cmmc = 'CM.L2-3.4.6, CM.L2-3.4.7' }
    '03.05.03' = @{ Title = 'Multi-factor authentication'; Family = 'Identification and Authentication'; CpcscLevel = 1; R2 = '3.5.3'; Cmmc = 'IA.L2-3.5.3 (not in CMMC Level 1)' }
    '03.05.07' = @{ Title = 'Password management'; Family = 'Identification and Authentication'; CpcscLevel = 2; R2 = '3.5.7'; Cmmc = 'IA.L2-3.5.7' }
    '03.08.07' = @{ Title = 'Media use'; Family = 'Media Protection'; CpcscLevel = 2; R2 = '3.8.7'; Cmmc = 'MP.L2-3.8.7' }
    '03.13.01' = @{ Title = 'Boundary protection'; Family = 'System and Communications Protection'; CpcscLevel = 1; R2 = '3.13.1, 3.13.5'; Cmmc = 'L1 (FAR 52.204-21 b.1.x, b.1.xi)' }
    '03.13.08' = @{ Title = 'Transmission and storage confidentiality'; Family = 'System and Communications Protection'; CpcscLevel = 2; R2 = '3.13.8, 3.13.16'; Cmmc = 'SC.L2-3.13.8, SC.L2-3.13.16' }
    '03.13.11' = @{ Title = 'Cryptographic protection'; Family = 'System and Communications Protection'; CpcscLevel = 2; R2 = '3.13.11'; Cmmc = 'SC.L2-3.13.11' }
    '03.14.01' = @{ Title = 'Flaw remediation'; Family = 'System and Information Integrity'; CpcscLevel = 1; R2 = '3.14.1'; Cmmc = 'L1 (FAR 52.204-21 b.1.xii)' }
    '03.14.02' = @{ Title = 'Malicious code protection'; Family = 'System and Information Integrity'; CpcscLevel = 1; R2 = '3.14.2, 3.14.4, 3.14.5'; Cmmc = 'L1 (FAR 52.204-21 b.1.xiii to b.1.xv)' }
    '03.14.09' = @{ Title = 'Dedicated administration workstation'; Family = 'System and Information Integrity'; CpcscLevel = 2; R2 = 'None (Canadian addition)'; Cmmc = 'None' }
}

$Results = New-Object System.Collections.Generic.List[object]

function Add-Result {
    param(
        [Parameter(Mandatory)][string]$Id,
        [Parameter(Mandatory)][string]$Check,
        [Parameter(Mandatory)][ValidateSet('PASS', 'FAIL', 'WARN', 'MANUAL', 'ERROR')][string]$Status,
        [string]$Expected = '',
        [string]$Actual = '',
        [string]$Note = ''
    )
    $m = $Map[$Id]
    $Results.Add([pscustomobject][ordered]@{
            ItspId     = $Id
            Title      = $m.Title
            Family     = $m.Family
            CpcscLevel = $m.CpcscLevel
            NistR3     = $Id
            NistR2     = $m.R2
            Cmmc       = $m.Cmmc
            Check      = $Check
            Status     = $Status
            Expected   = $Expected
            Actual     = $Actual
            Note       = $Note
        })
}

function Get-RegValue {
    param([string]$Path, [string]$Name)
    try { (Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop).$Name } catch { $null }
}

$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$NeedsAdmin = 'Run from an elevated PowerShell prompt for this check.'

# --- Security policy export (password and lockout settings) ----------------------------------
$SecPol = @{}
$SecPolNote = $NeedsAdmin
if ($IsAdmin) {
    try {
        $tmp = Join-Path -Path $env:TEMP -ChildPath ("cpcsc-secpol-{0}.inf" -f [guid]::NewGuid())
        $null = & secedit.exe /export /cfg $tmp /areas SECURITYPOLICY /quiet
        Get-Content -Path $tmp | ForEach-Object {
            if ($_ -match '^\s*([A-Za-z]+)\s*=\s*(.+?)\s*$') { $SecPol[$Matches[1]] = $Matches[2] }
        }
        Remove-Item -Path $tmp -Force -ErrorAction SilentlyContinue
    } catch { Write-Verbose "secedit export failed: $_"; $SecPolNote = "secedit export failed: $_" }
    if ($SecPol.Count -eq 0 -and $SecPolNote -eq $NeedsAdmin) { $SecPolNote = 'Elevated, but the secedit export returned no settings.' }
}

# --- 03.01.01 Account management --------------------------------------------------------------
try {
    $users = Get-LocalUser
    $guest = $users | Where-Object { $_.SID -like '*-501' }
    if ($guest -and $guest.Enabled) {
        Add-Result -Id '03.01.01' -Check 'Built-in Guest account disabled' -Status FAIL -Expected 'Disabled' -Actual 'Enabled'
    } else {
        Add-Result -Id '03.01.01' -Check 'Built-in Guest account disabled' -Status PASS -Expected 'Disabled' -Actual 'Disabled'
    }
    $cutoff = (Get-Date).AddDays(-$InactiveDays)
    $stale = @($users | Where-Object { $_.Enabled -and $_.SID -notlike '*-501' -and ($null -eq $_.LastLogon -or $_.LastLogon -lt $cutoff) })
    if ($stale.Count -gt 0) {
        $names = ($stale | ForEach-Object { if ($_.LastLogon) { '{0} (last logon {1:yyyy-MM-dd})' -f $_.Name, $_.LastLogon } else { '{0} (never logged on)' -f $_.Name } }) -join '; '
        Add-Result -Id '03.01.01' -Check "Enabled local accounts used in the last $InactiveDays days" -Status WARN -Expected "No enabled account idle over $InactiveDays days" -Actual $names -Note 'Disable accounts that are not needed, or record why each one stays enabled. Domain and cloud accounts are reviewed in the directory, not here.'
    } else {
        Add-Result -Id '03.01.01' -Check "Enabled local accounts used in the last $InactiveDays days" -Status PASS -Expected "No enabled account idle over $InactiveDays days" -Actual 'None found'
    }
} catch {
    Add-Result -Id '03.01.01' -Check 'Local account inventory' -Status ERROR -Note "$_"
}

# --- 03.01.05 / 03.01.06 Least privilege: local Administrators membership ---------------------
try {
    $admins = @(Get-LocalGroupMember -SID 'S-1-5-32-544' | Select-Object -ExpandProperty Name)
    Add-Result -Id '03.01.06' -Check 'Local Administrators group membership' -Status MANUAL -Expected 'Only approved administrator accounts' -Actual (($admins -join '; ') + " ($($admins.Count) members)") -Note 'Compare against your approved administrator list. Day-to-day work should not happen under an account in this group.'
} catch {
    Add-Result -Id '03.01.06' -Check 'Local Administrators group membership' -Status ERROR -Note "Get-LocalGroupMember failed (this cmdlet can fail when the group holds orphaned SIDs): $_"
}
$uac = Get-RegValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA'
if ($uac -eq 0) {
    Add-Result -Id '03.01.05' -Check 'User Account Control enabled' -Status FAIL -Expected 'EnableLUA = 1' -Actual 'EnableLUA = 0'
} else {
    Add-Result -Id '03.01.05' -Check 'User Account Control enabled' -Status PASS -Expected 'EnableLUA = 1' -Actual 'Enabled'
}

# --- 03.01.08 Unsuccessful logon attempts -----------------------------------------------------
if ($SecPol.ContainsKey('LockoutBadCount')) {
    $bad = [int]$SecPol['LockoutBadCount']
    if ($bad -ge 1 -and $bad -le $LockoutThreshold) {
        Add-Result -Id '03.01.08' -Check 'Account lockout threshold' -Status PASS -Expected "1 to $LockoutThreshold attempts" -Actual "$bad"
    } else {
        Add-Result -Id '03.01.08' -Check 'Account lockout threshold' -Status FAIL -Expected "1 to $LockoutThreshold attempts" -Actual $(if ($bad -eq 0) { '0 (no lockout)' } else { "$bad" })
    }
} else {
    Add-Result -Id '03.01.08' -Check 'Account lockout threshold' -Status ERROR -Note $SecPolNote
}

# --- 03.01.10 Device lock --------------------------------------------------------------------
$inact = Get-RegValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'InactivityTimeoutSecs'
$ssTimeout = Get-RegValue -Path 'HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop' -Name 'ScreenSaveTimeOut'
$ssSecure = Get-RegValue -Path 'HKCU:\Software\Policies\Microsoft\Windows\Control Panel\Desktop' -Name 'ScreenSaverIsSecure'
if ($inact -and [int]$inact -gt 0 -and [int]$inact -le $ScreenLockSeconds) {
    Add-Result -Id '03.01.10' -Check 'Machine inactivity lock' -Status PASS -Expected "Lock at or under $ScreenLockSeconds seconds" -Actual "InactivityTimeoutSecs = $inact"
} elseif ($ssTimeout -and [int]$ssTimeout -gt 0 -and [int]$ssTimeout -le $ScreenLockSeconds -and $ssSecure -eq '1') {
    Add-Result -Id '03.01.10' -Check 'Machine inactivity lock' -Status PASS -Expected "Lock at or under $ScreenLockSeconds seconds" -Actual "Policy screen saver at $ssTimeout seconds, password protected (current user)"
} else {
    $act = if ($inact) { "InactivityTimeoutSecs = $inact" } else { 'No machine inactivity limit or enforced locking screen saver found' }
    Add-Result -Id '03.01.10' -Check 'Machine inactivity lock' -Status FAIL -Expected "Lock at or under $ScreenLockSeconds seconds" -Actual $act -Note 'Set "Interactive logon: Machine inactivity limit" by Group Policy or Intune.'
}

# --- 03.01.12 Remote access ------------------------------------------------------------------
$rdpOff = Get-RegValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections'
$nla = Get-RegValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'UserAuthentication'
if ($rdpOff -eq 1) {
    Add-Result -Id '03.01.12' -Check 'Remote Desktop exposure' -Status PASS -Expected 'Disabled, or enabled with NLA through a controlled path' -Actual 'Remote Desktop disabled'
} elseif ($nla -eq 1) {
    Add-Result -Id '03.01.12' -Check 'Remote Desktop exposure' -Status WARN -Expected 'Disabled, or enabled with NLA through a controlled path' -Actual 'Enabled with Network Level Authentication' -Note 'Confirm RDP is reachable only from a jump host or management network, with MFA on that path.'
} else {
    Add-Result -Id '03.01.12' -Check 'Remote Desktop exposure' -Status FAIL -Expected 'Disabled, or enabled with NLA through a controlled path' -Actual 'Enabled without Network Level Authentication'
}
$remoteTools = 'TeamViewer|AnyDesk|ScreenConnect|ConnectWise Control|Splashtop|LogMeIn|RemotePC|Chrome Remote Desktop|RustDesk|VNC'
$uninstallKeys = @('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*')
$found = @(Get-ItemProperty -Path $uninstallKeys -ErrorAction SilentlyContinue | Where-Object { $_.PSObject.Properties['DisplayName'] -and $_.DisplayName -match $remoteTools } | Select-Object -ExpandProperty DisplayName -Unique)
if ($found.Count -gt 0) {
    Add-Result -Id '03.01.12' -Check 'Third-party remote access tools installed' -Status WARN -Expected 'Only approved remote tools, reached through a controlled path' -Actual ($found -join '; ') -Note 'Each tool needs MFA, session recording, and a documented reason to be here. Unapproved tools should go.'
} else {
    Add-Result -Id '03.01.12' -Check 'Third-party remote access tools installed' -Status PASS -Expected 'Only approved remote tools' -Actual 'None of the common tools detected'
}

# --- 03.03.01 Event logging ------------------------------------------------------------------
if ($IsAdmin) {
    $subcats = [ordered]@{
        'Logon'                     = @{ Guid = '{0CCE9215-69AE-11D9-BED3-505054503030}'; Need = 'Success and Failure' }
        'Account Lockout'           = @{ Guid = '{0CCE9217-69AE-11D9-BED3-505054503030}'; Need = 'Failure' }
        'User Account Management'   = @{ Guid = '{0CCE9235-69AE-11D9-BED3-505054503030}'; Need = 'Success' }
        'Security Group Management' = @{ Guid = '{0CCE9237-69AE-11D9-BED3-505054503030}'; Need = 'Success' }
        'Audit Policy Change'       = @{ Guid = '{0CCE922F-69AE-11D9-BED3-505054503030}'; Need = 'Success' }
    }
    foreach ($k in $subcats.Keys) {
        try {
            $row = & auditpol.exe /get /subcategory:$($subcats[$k].Guid) /r | ConvertFrom-Csv | Select-Object -First 1
            $setting = $row.'Inclusion Setting'
            $need = $subcats[$k].Need
            $ok = switch ($need) {
                'Success and Failure' { $setting -match 'Success' -and $setting -match 'Failure' }
                'Success' { $setting -match 'Success' }
                'Failure' { $setting -match 'Failure' }
            }
            Add-Result -Id '03.03.01' -Check "Audit policy: $k" -Status $(if ($ok) { 'PASS' } else { 'FAIL' }) -Expected $need -Actual $setting
        } catch {
            Add-Result -Id '03.03.01' -Check "Audit policy: $k" -Status ERROR -Note "$_"
        }
    }
    try {
        $sec = Get-WinEvent -ListLog Security
        $kb = [int]($sec.MaximumSizeInBytes / 1KB)
        Add-Result -Id '03.03.01' -Check 'Security event log size' -Status $(if ($kb -ge $SecurityLogMinKB) { 'PASS' } else { 'WARN' }) -Expected "At least $SecurityLogMinKB KB" -Actual "$kb KB, mode $($sec.LogMode)"
    } catch {
        Add-Result -Id '03.03.01' -Check 'Security event log size' -Status ERROR -Note "$_"
    }
} else {
    Add-Result -Id '03.03.01' -Check 'Audit policy and Security log' -Status ERROR -Note $NeedsAdmin
}
Add-Result -Id '03.03.01' -Check 'Logs sent to a central log server' -Status MANUAL -Expected 'Events forwarded off the machine and reviewed' -Note 'A script on the endpoint cannot confirm collection. Evidence is the collector showing this host, plus a dated review record.'

# --- 03.03.07 Time stamps --------------------------------------------------------------------
$w32type = Get-RegValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\W32Time\Parameters' -Name 'Type'
$w32src = ''
try { $w32src = ((& w32tm.exe /query /source) | Out-String).Trim() } catch { $w32src = '' }
if ($w32type -eq 'NoSync' -or $w32src -match 'Local CMOS Clock|Free-running System Clock') {
    Add-Result -Id '03.03.07' -Check 'Time synchronization' -Status FAIL -Expected 'Synchronized to the domain hierarchy or an authoritative NTP source' -Actual "Type = $w32type; Source = $w32src"
} elseif ($w32type) {
    Add-Result -Id '03.03.07' -Check 'Time synchronization' -Status PASS -Expected 'Synchronized to the domain hierarchy or an authoritative NTP source' -Actual "Type = $w32type; Source = $w32src" -Note 'Use the same source for servers, door controllers, and video recorders so event times line up.'
} else {
    Add-Result -Id '03.03.07' -Check 'Time synchronization' -Status ERROR -Note 'W32Time configuration not readable.'
}

# --- 03.04.06 Least functionality ------------------------------------------------------------
try {
    $smb1 = (Get-SmbServerConfiguration -ErrorAction Stop).EnableSMB1Protocol
    Add-Result -Id '03.04.06' -Check 'SMBv1 server protocol disabled' -Status $(if ($smb1) { 'FAIL' } else { 'PASS' }) -Expected 'Disabled' -Actual $(if ($smb1) { 'Enabled' } else { 'Disabled' })
} catch {
    Add-Result -Id '03.04.06' -Check 'SMBv1 server protocol disabled' -Status ERROR -Note $(if ($IsAdmin) { "$_" } else { $NeedsAdmin })
}
$autorun = Get-RegValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun'
Add-Result -Id '03.04.06' -Check 'AutoRun disabled on all drives' -Status $(if ($autorun -eq 255) { 'PASS' } else { 'FAIL' }) -Expected 'NoDriveTypeAutoRun = 255' -Actual $(if ($null -eq $autorun) { 'Not set' } else { "$autorun" })

# --- 03.05.03 Multi-factor authentication ----------------------------------------------------
Add-Result -Id '03.05.03' -Check 'MFA on privileged and non-privileged access' -Status MANUAL -Expected 'MFA enforced on every path into systems holding Specified Information' -Note 'Level 1 requirement. Evidence lives in your identity provider: the conditional access or MFA policy, and an enrolment report covering every account. CMMC Level 1 does not require MFA.'

# --- 03.05.07 Password management ------------------------------------------------------------
if ($SecPol.ContainsKey('MinimumPasswordLength')) {
    $len = [int]$SecPol['MinimumPasswordLength']
    Add-Result -Id '03.05.07' -Check 'Minimum password length' -Status $(if ($len -ge $MinPasswordLength) { 'PASS' } else { 'FAIL' }) -Expected "At least $MinPasswordLength characters" -Actual "$len" -Note 'Local and domain policy as applied to this machine. Breached-password screening is checked in your identity provider.'
} else {
    Add-Result -Id '03.05.07' -Check 'Minimum password length' -Status ERROR -Note $SecPolNote
}

# --- 03.08.07 Media use ----------------------------------------------------------------------
$denyAll = Get-RegValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices' -Name 'Deny_All'
$denyWrite = Get-RegValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write'
if ($denyAll -eq 1) {
    Add-Result -Id '03.08.07' -Check 'Removable storage restricted' -Status PASS -Expected 'Blocked, or allowed only for approved encrypted devices' -Actual 'All removable storage denied by policy'
} elseif ($denyWrite -eq 1) {
    Add-Result -Id '03.08.07' -Check 'Removable storage restricted' -Status PASS -Expected 'Blocked, or allowed only for approved encrypted devices' -Actual 'Write access to removable disks denied by policy'
} else {
    Add-Result -Id '03.08.07' -Check 'Removable storage restricted' -Status WARN -Expected 'Blocked, or allowed only for approved encrypted devices' -Actual 'No removable storage restriction policy found' -Note 'If USB storage is allowed on purpose, record the approved devices and the encryption rule in your media policy.'
}

# --- 03.13.01 Boundary protection: host firewall ---------------------------------------------
try {
    foreach ($p in Get-NetFirewallProfile) {
        $inbound = "$($p.DefaultInboundAction)"
        $okIn = ($inbound -eq 'Block' -or $inbound -eq 'NotConfigured')
        $status = if ($p.Enabled -and $okIn) { 'PASS' } else { 'FAIL' }
        Add-Result -Id '03.13.01' -Check "Windows Firewall, $($p.Name) profile" -Status $status -Expected 'Enabled, inbound blocked by default' -Actual "Enabled = $($p.Enabled); default inbound = $inbound" -Note 'The host firewall supports, and does not replace, the boundary firewall between the enclave and everything else.'
    }
} catch {
    Add-Result -Id '03.13.01' -Check 'Windows Firewall profiles' -Status ERROR -Note "$_"
}

# --- 03.13.08 Transmission and storage confidentiality: BitLocker ----------------------------
if ($IsAdmin) {
    try {
        $vols = @(Get-BitLockerVolume -ErrorAction Stop | Where-Object { $_.VolumeType -in 'OperatingSystem', 'Data' })
        foreach ($v in $vols) {
            $ok = ("$($v.ProtectionStatus)" -eq 'On' -and "$($v.VolumeStatus)" -eq 'FullyEncrypted')
            Add-Result -Id '03.13.08' -Check "BitLocker on $($v.MountPoint)" -Status $(if ($ok) { 'PASS' } else { 'FAIL' }) -Expected 'Fully encrypted, protection on' -Actual "$($v.VolumeStatus), protection $($v.ProtectionStatus), $($v.EncryptionMethod)" -Note 'Encryption at rest applies wherever Specified Information is stored, not only on portable devices.'
        }
        if ($vols.Count -eq 0) { Add-Result -Id '03.13.08' -Check 'BitLocker volumes' -Status ERROR -Note 'No fixed volumes returned.' }
    } catch {
        Add-Result -Id '03.13.08' -Check 'BitLocker' -Status ERROR -Note "BitLocker not available or not readable on this edition: $_"
    }
} else {
    Add-Result -Id '03.13.08' -Check 'BitLocker' -Status ERROR -Note $NeedsAdmin
}

# --- 03.13.11 Cryptographic protection: legacy TLS -------------------------------------------
foreach ($proto in 'TLS 1.0', 'TLS 1.1') {
    $base = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\$proto"
    $srv = Get-RegValue -Path "$base\Server" -Name 'Enabled'
    $cli = Get-RegValue -Path "$base\Client" -Name 'Enabled'
    if ($srv -eq 0 -and $cli -eq 0) {
        Add-Result -Id '03.13.11' -Check "$proto disabled" -Status PASS -Expected 'Disabled for client and server' -Actual 'Disabled by policy'
    } else {
        Add-Result -Id '03.13.11' -Check "$proto disabled" -Status WARN -Expected 'Disabled for client and server' -Actual "Server = $(if ($null -eq $srv) { 'OS default' } else { $srv }); Client = $(if ($null -eq $cli) { 'OS default' } else { $cli })" -Note 'Recent Windows releases disable these by default; set them explicitly so the configuration is evidence rather than an assumption.'
    }
}

# --- 03.14.01 Flaw remediation ---------------------------------------------------------------
try {
    $session = New-Object -ComObject Microsoft.Update.Session
    $searcher = $session.CreateUpdateSearcher()
    $total = $searcher.GetTotalHistoryCount()
    $last = $null
    if ($total -gt 0) {
        # Definition updates and the Malicious Software Removal Tool land in history almost daily and say nothing about OS patching.
        $noise = 'Security Intelligence Update|Definition Update|Malicious Software Removal Tool|antimalware platform|Platform Update for Microsoft Defender'
        $last = $searcher.QueryHistory(0, [Math]::Min($total, 500)) | Where-Object { $_.ResultCode -eq 2 -and $_.Operation -eq 1 -and $_.Title -notmatch $noise } | Sort-Object -Property Date -Descending | Select-Object -First 1
    }
    if ($last) {
        $age = [int]((Get-Date) - $last.Date).TotalDays
        Add-Result -Id '03.14.01' -Check 'Most recent successful update' -Status $(if ($age -le $PatchDays) { 'PASS' } else { 'FAIL' }) -Expected "Within $PatchDays days" -Actual ('{0:yyyy-MM-dd} ({1} days ago): {2}' -f $last.Date, $age, $last.Title)
    } else {
        Add-Result -Id '03.14.01' -Check 'Most recent successful update' -Status FAIL -Expected "Within $PatchDays days" -Actual 'No successful OS or software update found in Windows Update history' -Note 'If updates come through WSUS, Intune, or a third-party tool, confirm there instead.'
    }
} catch {
    Add-Result -Id '03.14.01' -Check 'Most recent successful update' -Status ERROR -Note "Windows Update history not readable: $_"
}
if (Test-Path -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired') {
    Add-Result -Id '03.14.01' -Check 'Pending reboot to finish updates' -Status WARN -Expected 'No pending reboot' -Actual 'Reboot required'
} else {
    Add-Result -Id '03.14.01' -Check 'Pending reboot to finish updates' -Status PASS -Expected 'No pending reboot' -Actual 'None'
}

# --- 03.14.02 Malicious code protection ------------------------------------------------------
$mpOk = $false
try {
    $mp = Get-MpComputerStatus -ErrorAction Stop
    $fresh = ($mp.AntivirusSignatureAge -le $SignatureMaxAgeDays)
    $mode = if ($mp.PSObject.Properties['AMRunningMode']) { "$($mp.AMRunningMode)" } else { 'Unknown' }
    $passive = ($mode -match 'Passive|EDR Block|Not running')
    $mpOk = ($mp.AMServiceEnabled -and $mp.AntivirusEnabled -and $mp.RealTimeProtectionEnabled -and -not $passive)
    Add-Result -Id '03.14.02' -Check 'Microsoft Defender real-time protection' -Status $(if ($mpOk) { 'PASS' } else { 'WARN' }) -Expected 'Service, antivirus, and real-time protection on, running in normal mode' -Actual "Service = $($mp.AMServiceEnabled); AV = $($mp.AntivirusEnabled); real-time = $($mp.RealTimeProtectionEnabled); mode = $mode" -Note $(if ($mpOk) { '' } else { 'Expected if another antivirus product is the active one; see the next result.' })
    if ($mpOk) {
        Add-Result -Id '03.14.02' -Check 'Defender signature age' -Status $(if ($fresh) { 'PASS' } else { 'FAIL' }) -Expected "At most $SignatureMaxAgeDays days old" -Actual "$($mp.AntivirusSignatureAge) days (version $($mp.AntivirusSignatureVersion))"
    }
} catch {
    Add-Result -Id '03.14.02' -Check 'Microsoft Defender status' -Status WARN -Actual 'Get-MpComputerStatus unavailable' -Note "$_"
}
if (-not $mpOk) {
    try {
        $av = @(Get-CimInstance -Namespace 'root/SecurityCenter2' -ClassName AntiVirusProduct -ErrorAction Stop)
        if ($av.Count -gt 0) {
            $desc = ($av | ForEach-Object {
                    $hex = '{0:X6}' -f [int]$_.productState
                    $on = $hex.Substring(2, 2) -in '10', '11'
                    $current = $hex.Substring(4, 2) -eq '00'
                    '{0} (enabled = {1}, definitions current = {2})' -f $_.displayName, $on, $current
                }) -join '; '
            Add-Result -Id '03.14.02' -Check 'Registered antivirus products' -Status MANUAL -Expected 'An active, current antivirus product' -Actual $desc -Note 'Confirm in the product console that real-time protection is on and definitions are current.'
        } else {
            Add-Result -Id '03.14.02' -Check 'Registered antivirus products' -Status FAIL -Expected 'An active, current antivirus product' -Actual 'None registered'
        }
    } catch {
        Add-Result -Id '03.14.02' -Check 'Registered antivirus products' -Status ERROR -Note 'Security Center is not available (common on Windows Server). Check the antivirus console.'
    }
}

# --- 03.14.09 Dedicated administration workstation -------------------------------------------
Add-Result -Id '03.14.09' -Check 'Administrative work from a dedicated, isolated workstation' -Status MANUAL -Expected 'Admin actions only from a hardened single-purpose workstation isolated from the internet' -Note 'Canada added this requirement to the NIST set. A script on one endpoint cannot prove where administration happens; document the admin workstations and the paths they use.'

# ---------------------------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------------------------
$cs = $null; $os = $null
try { $cs = Get-CimInstance -ClassName Win32_ComputerSystem } catch { Write-Verbose "$_" }
try { $os = Get-CimInstance -ClassName Win32_OperatingSystem } catch { Write-Verbose "$_" }
$stamp = Get-Date
$meta = [ordered]@{
    Tool          = 'Invoke-CpcscEndpointAudit'
    ToolVersion   = $ScriptVersion
    Standard      = 'ITSP.10.171 (second release, October 28, 2025) / NIST SP 800-171 Rev 3'
    ComputerName  = $env:COMPUTERNAME
    Domain        = $(if ($cs) { $cs.Domain } else { '' })
    PartOfDomain  = $(if ($cs) { [bool]$cs.PartOfDomain } else { $false })
    OS            = $(if ($os) { "$($os.Caption) $($os.Version)" } else { '' })
    RunAs         = "$env:USERDOMAIN\$env:USERNAME"
    Elevated      = $IsAdmin
    RunAt         = $stamp.ToString('o')
    Parameters    = [ordered]@{ InactiveDays = $InactiveDays; PatchDays = $PatchDays; SignatureMaxAgeDays = $SignatureMaxAgeDays; MinPasswordLength = $MinPasswordLength; LockoutThreshold = $LockoutThreshold; ScreenLockSeconds = $ScreenLockSeconds; SecurityLogMinKB = $SecurityLogMinKB }
    Summary       = [ordered]@{}
}
foreach ($s in 'PASS', 'FAIL', 'WARN', 'MANUAL', 'ERROR') { $meta.Summary[$s] = @($Results | Where-Object { $_.Status -eq $s }).Count }

if (-not (Test-Path -Path $OutputPath)) { $null = New-Item -Path $OutputPath -ItemType Directory -Force }
$baseName = 'cpcsc-audit-{0}-{1:yyyyMMdd-HHmmss}' -f $env:COMPUTERNAME, $stamp
$jsonPath = Join-Path -Path $OutputPath -ChildPath "$baseName.json"
$csvPath = Join-Path -Path $OutputPath -ChildPath "$baseName.csv"
$htmlPath = Join-Path -Path $OutputPath -ChildPath "$baseName.html"

[ordered]@{ Metadata = $meta; Results = $Results } | ConvertTo-Json -Depth 6 | Set-Content -Path $jsonPath -Encoding UTF8
$Results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

if (-not $NoHtml) {
    $enc = { param($t) [System.Net.WebUtility]::HtmlEncode([string]$t) }
    $rows = foreach ($r in $Results) {
        "<tr><td class='mono'>$(& $enc $r.ItspId)</td><td>$(& $enc $r.Title)<div class='sub'>L$($r.CpcscLevel) &middot; 800-171 r2 $(& $enc $r.NistR2) &middot; CMMC $(& $enc $r.Cmmc)</div></td><td>$(& $enc $r.Check)</td><td><span class='st $($r.Status.ToLower())'>$($r.Status)</span></td><td>$(& $enc $r.Expected)</td><td>$(& $enc $r.Actual)<div class='sub'>$(& $enc $r.Note)</div></td></tr>"
    }
    $sum = ($meta.Summary.GetEnumerator() | ForEach-Object { "<div class='stat'><span class='st $($_.Key.ToLower())'>$($_.Key)</span><b>$($_.Value)</b></div>" }) -join ''
    $html = @"
<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>CPCSC endpoint audit: $(& $enc $env:COMPUTERNAME)</title>
<style>
:root{--bg:#121519;--sf:#181c22;--bd:#2c333d;--wh:#eaf0f5;--tx:#b7c0c9;--tx2:#8d98a3;--or:#df7a1e;--od:#9aa056;--rd:#e26a5d;--ok:#68d391}
body{background:var(--bg);color:var(--tx);font:14px/1.5 "IBM Plex Sans",Segoe UI,Arial,sans-serif;margin:0;padding:32px}
h1{color:var(--wh);font:700 34px/1.1 "Barlow Condensed",Segoe UI,Arial,sans-serif;margin:6px 0 4px}
.eb{font:12px "Share Tech Mono",Consolas,monospace;letter-spacing:.16em;text-transform:uppercase;color:var(--tx2)}.eb b{color:var(--or);font-weight:400}
.mono{font-family:"Share Tech Mono",Consolas,monospace;color:var(--od);white-space:nowrap}
.meta{color:var(--tx2);margin:6px 0 18px}.stats{display:flex;gap:12px;flex-wrap:wrap;margin:0 0 20px}
.stat{background:var(--sf);border:1px solid var(--bd);border-radius:2px;padding:10px 14px;display:flex;gap:10px;align-items:center}.stat b{color:var(--wh);font-size:20px}
table{width:100%;border-collapse:collapse;background:var(--sf);border:1px solid var(--bd)}th,td{text-align:left;vertical-align:top;padding:9px 10px;border-bottom:1px solid var(--bd)}
th{color:var(--wh);font-weight:600;border-bottom:1px solid var(--or)}.sub{color:var(--tx2);font-size:12px;margin-top:3px}
.st{font:12px "Share Tech Mono",Consolas,monospace;padding:2px 7px;border-radius:2px;border:1px solid}.pass{color:var(--ok);border-color:var(--ok)}.fail{color:var(--rd);border-color:var(--rd)}.warn{color:var(--or);border-color:var(--or)}.manual{color:var(--od);border-color:var(--od)}.error{color:var(--tx2);border-color:var(--tx2)}
.note{margin-top:20px;color:var(--tx2);font-size:12px}a{color:var(--or)}
</style></head><body>
<div class="eb"><b>// </b>CPCSC readiness &middot; ITSP.10.171 endpoint audit</div>
<h1>$(& $enc $env:COMPUTERNAME)</h1>
<div class="meta">$(& $enc $meta.OS) &middot; $(& $enc $meta.Domain) &middot; run $(& $enc $stamp.ToString('yyyy-MM-dd HH:mm')) as $(& $enc $meta.RunAs) &middot; elevated: $IsAdmin</div>
<div class="stats">$sum</div>
<table><thead><tr><th>ITSP.10.171</th><th>Requirement</th><th>Check</th><th>Status</th><th>Expected</th><th>Found</th></tr></thead><tbody>
$($rows -join "`n")
</tbody></table>
<div class="note">Organization-defined parameters used: inactive accounts $InactiveDays days, patch age $PatchDays days, signature age $SignatureMaxAgeDays days, password length $MinPasswordLength, lockout $LockoutThreshold attempts, device lock $ScreenLockSeconds seconds, Security log $SecurityLogMinKB KB. Record your chosen values in your system security plan.<br>
This report is evidence for one machine. It is not a CPCSC attestation, certification, or assessment, and Rev 2 and CMMC mappings are approximate; confirm against NIST's official crosswalk. Report from Invoke-CpcscEndpointAudit $ScriptVersion, <a href="https://hans.study/cpcsc/">hans.study/cpcsc</a>.</div>
</body></html>
"@
    Set-Content -Path $htmlPath -Value $html -Encoding UTF8
}

Write-Host ''
Write-Host ("CPCSC endpoint audit for {0}" -f $env:COMPUTERNAME)
foreach ($s in 'PASS', 'FAIL', 'WARN', 'MANUAL', 'ERROR') { Write-Host ("  {0,-7}{1}" -f $s, $meta.Summary[$s]) }
if (-not $IsAdmin) { Write-Warning 'Not elevated: several checks returned ERROR. Re-run as administrator for a complete report.' }
Write-Host ("Report: {0}" -f $(if ($NoHtml) { $jsonPath } else { $htmlPath }))
