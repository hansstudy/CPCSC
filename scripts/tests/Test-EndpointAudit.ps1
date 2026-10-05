#Requires -Version 7.0
<#
.SYNOPSIS
    Runs Invoke-CpcscEndpointAudit.ps1 against stubbed Windows commands and checks the results.

.DESCRIPTION
    The endpoint script reads Windows-only settings, so this harness replaces those commands with stubs and
    forces the elevation check, which lets the script run on any OS under PowerShell 7. It exercises the
    branches that depend on stubbed data (account checks, Defender modes, policy export failures) and checks
    the update-history noise filter. It doesn't replace running the script on a real Windows machine.

.EXAMPLE
    pwsh ./scripts/tests/Test-EndpointAudit.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
$script:work = Join-Path -Path ([IO.Path]::GetTempPath()) -ChildPath ("cpcsc-test-{0}" -f [guid]::NewGuid())
$null = New-Item -Path $script:work -ItemType Directory -Force
$script:failures = 0

function Assert-That {
    param([bool]$Condition, [string]$Message)
    if ($Condition) { Write-Host "  ok    $Message" } else { Write-Host "  FAIL  $Message"; $script:failures++ }
}

function Invoke-Audit {
    param([string]$Scenario)
    $env:COMPUTERNAME = 'TESTPC'; $env:USERDOMAIN = 'EXAMPLE'; $env:USERNAME = 'tester'; $env:TEMP = $script:work
    $src = (Get-Content -Path (Join-Path $repo 'scripts/Invoke-CpcscEndpointAudit.ps1') -Raw) -replace '(?m)^\$IsAdmin = .*$', '$IsAdmin = $true'
    $copy = Join-Path $script:work 'under-test.ps1'
    Set-Content -Path $copy -Value $src

    $global:CpcscTestScenario = $Scenario
    function global:Get-LocalUser { @([pscustomobject]@{ Name = 'Guest'; SID = 'S-1-5-21-1-501'; Enabled = ($global:CpcscTestScenario -eq 'guest'); LastLogon = $null },
            [pscustomobject]@{ Name = 'alice'; SID = 'S-1-5-21-1-1001'; Enabled = $true; LastLogon = (Get-Date).AddDays(-2) },
            [pscustomobject]@{ Name = 'old'; SID = 'S-1-5-21-1-1002'; Enabled = $true; LastLogon = (Get-Date).AddDays(-90) }) }
    function global:Get-LocalGroupMember { param($SID) @([pscustomobject]@{ Name = 'EXAMPLE\alice' }) }
    function global:secedit.exe { $cfg = $args[2]; if ($global:CpcscTestScenario -ne 'nosecpol') { Set-Content -Path $cfg -Value "[System Access]`nMinimumPasswordLength = 14`nLockoutBadCount = 5`n" } }
    function global:auditpol.exe { 'Machine Name,Policy Target,Subcategory,Subcategory GUID,Inclusion Setting,Exclusion Setting'; 'TESTPC,System,X,{x},Success and Failure,' }
    function global:w32tm.exe { 'time.windows.com' }
    function global:Get-WinEvent { [pscustomobject]@{ MaximumSizeInBytes = 200MB; LogMode = 'Circular' } }
    function global:Get-SmbServerConfiguration { [pscustomobject]@{ EnableSMB1Protocol = $false } }
    function global:Get-NetFirewallProfile { 'Domain', 'Private', 'Public' | ForEach-Object { [pscustomobject]@{ Name = $_; Enabled = $true; DefaultInboundAction = 'Block' } } }
    function global:Get-BitLockerVolume { [pscustomobject]@{ VolumeType = 'OperatingSystem'; MountPoint = 'C:'; ProtectionStatus = 'On'; VolumeStatus = 'FullyEncrypted'; EncryptionMethod = 'XtsAes256' } }
    function global:Get-MpComputerStatus {
        $o = [ordered]@{ AMServiceEnabled = $true; AntivirusEnabled = $true; RealTimeProtectionEnabled = $true; AntivirusSignatureAge = 1; AntivirusSignatureVersion = '1.0' }
        switch ($global:CpcscTestScenario) { 'passive' { $o['AMRunningMode'] = 'Passive Mode' } 'nomode' { } default { $o['AMRunningMode'] = 'Normal' } }
        [pscustomobject]$o
    }
    function global:Get-CimInstance { param($ClassName, $Namespace)
        if ($ClassName -eq 'AntiVirusProduct') { [pscustomobject]@{ displayName = 'ThirdPartyAV'; productState = 266240 } }
        elseif ($ClassName -eq 'Win32_ComputerSystem') { [pscustomobject]@{ Domain = 'example.invalid'; PartOfDomain = $true } }
        else { [pscustomobject]@{ Caption = 'Microsoft Windows 11 Pro'; Version = '10.0.26100' } } }

    $out = Join-Path $script:work "out-$Scenario"
    $null = & $copy -OutputPath $out -NoHtml 6>&1
    (Get-Content -Path (Get-ChildItem -Path $out -Filter *.json).FullName -Raw | ConvertFrom-Json).Results
}

function Get-Row($rows, $id, $like) { @($rows | Where-Object { $_.ItspId -eq $id -and $_.Check -like $like })[0] }

try {
    Write-Host 'Scenario: good'
    $r = Invoke-Audit 'good'
    Assert-That ((Get-Row $r '03.01.01' 'Built-in Guest*').Status -eq 'PASS') 'Guest account disabled passes'
    Assert-That ((Get-Row $r '03.01.01' 'Enabled local*').Status -eq 'WARN') 'Idle local account is flagged'
    Assert-That ((Get-Row $r '03.01.08' '*').Status -eq 'PASS') 'Lockout threshold of 5 passes'
    Assert-That ((Get-Row $r '03.05.07' '*').Status -eq 'PASS') 'Password length of 14 passes'
    Assert-That ((Get-Row $r '03.14.02' 'Microsoft Defender real-time*').Status -eq 'PASS') 'Defender in normal mode passes'
    Assert-That ((Get-Row $r '03.05.03' '*').Status -eq 'MANUAL') 'MFA stays a manual item'
    Assert-That (@($r | Where-Object { $_.ItspId -eq '03.13.01' }).Count -eq 3) 'Firewall is checked for 3 profiles'

    Write-Host 'Scenario: guest enabled'
    $r = Invoke-Audit 'guest'
    Assert-That ((Get-Row $r '03.01.01' 'Built-in Guest*').Status -eq 'FAIL') 'Enabled Guest account fails'

    Write-Host 'Scenario: Defender in passive mode'
    $r = Invoke-Audit 'passive'
    Assert-That ((Get-Row $r '03.14.02' 'Microsoft Defender real-time*').Status -eq 'WARN') 'Passive mode does not pass'
    Assert-That ((Get-Row $r '03.14.02' 'Registered antivirus*').Status -eq 'MANUAL') 'Registered products are listed for review'

    Write-Host 'Scenario: Defender without AMRunningMode'
    $r = Invoke-Audit 'nomode'
    Assert-That ((Get-Row $r '03.14.02' 'Microsoft Defender real-time*').Actual -like '*mode = Unknown*') 'Missing property reports Unknown instead of failing'

    Write-Host 'Scenario: security policy export fails'
    $r = Invoke-Audit 'nosecpol'
    Assert-That ((Get-Row $r '03.01.08' '*').Status -eq 'ERROR') 'Lockout check reports ERROR'
    Assert-That ((Get-Row $r '03.01.08' '*').Note -like '*secedit export failed*') 'ERROR note names the export failure'

    Write-Host 'Update history filter'
    $line = Select-String -Path (Join-Path $repo 'scripts/Invoke-CpcscEndpointAudit.ps1') -Pattern '\$noise = ''([^'']+)''' | Select-Object -First 1
    $noise = $line.Matches[0].Groups[1].Value
    foreach ($t in '2026-09 Cumulative Update for Windows 11 Version 24H2 (KB5043080)', 'Security Update for Microsoft Office 2016 (KB5002000)', '.NET Framework 4.8.1 Cumulative Update') {
        Assert-That ($t -notmatch $noise) "Counts as patching: $t"
    }
    foreach ($t in 'Security Intelligence Update for Microsoft Defender Antivirus - KB2267602', 'Windows Malicious Software Removal Tool x64 - v5.130 (KB890830)', 'Update for Microsoft Defender Antivirus antimalware platform - KB4052623', 'Definition Update for Windows Defender Antivirus - KB2267602') {
        Assert-That ($t -match $noise) "Ignored as noise: $t"
    }
} finally {
    Remove-Item -Path $script:work -Recurse -Force -ErrorAction SilentlyContinue
}

if ($script:failures -gt 0) { Write-Host "`n$script:failures check(s) failed"; exit 1 }
Write-Host "`nAll checks passed"
