#Requires -Version 5.1
<#
.SYNOPSIS
    Merges Invoke-CpcscEndpointAudit JSON reports into a fleet summary.

.DESCRIPTION
    Reads every cpcsc-audit-*.json file in -ReportPath (the newest report per computer wins) and writes:
      - fleet-summary.csv   one row per computer and check, ready for a spreadsheet or a gap register
      - fleet-matrix.csv    one row per check, one column per computer, cells holding the status
      - fleet-summary.html  dark-theme summary with pass, fail, and warn counts per requirement

    Collect the JSON files however suits you: a file share the endpoint script writes to, an Intune or
    RMM script output, or copying them by hand. Nothing here connects to the endpoints.

.PARAMETER ReportPath
    Folder holding the JSON reports. Default: .\reports

.PARAMETER OutputPath
    Folder for the summary files. Default: same as ReportPath.

.EXAMPLE
    .\Merge-CpcscAuditReports.ps1 -ReportPath \\fileserver\cpcsc\reports

.NOTES
    Project : cpcsc-itsp-10-171-readiness
    Author  : Hans Study, hans.study
    License : MIT
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Console summary for an interactive tool; results go to the report files.')]
[CmdletBinding()]
param(
    [string]$ReportPath = (Join-Path -Path (Get-Location) -ChildPath 'reports'),
    [string]$OutputPath
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
if (-not $OutputPath) { $OutputPath = $ReportPath }
if (-not (Test-Path -Path $ReportPath)) { throw "Report folder not found: $ReportPath" }

$files = @(Get-ChildItem -Path $ReportPath -Filter 'cpcsc-audit-*.json' -File)
if ($files.Count -eq 0) { throw "No cpcsc-audit-*.json files in $ReportPath" }

# Newest report per computer
$latest = @{}
foreach ($f in $files) {
    try {
        $doc = Get-Content -Path $f.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
        $name = $doc.Metadata.ComputerName
        $when = [datetime]$doc.Metadata.RunAt
        if (-not $latest.ContainsKey($name) -or $when -gt $latest[$name].When) {
            $latest[$name] = @{ When = $when; Doc = $doc }
        }
    } catch { Write-Warning "Skipped $($f.Name): $_" }
}

$rows = New-Object System.Collections.Generic.List[object]
foreach ($name in ($latest.Keys | Sort-Object)) {
    $doc = $latest[$name].Doc
    foreach ($r in $doc.Results) {
        $rows.Add([pscustomobject][ordered]@{
                ComputerName = $name
                RunAt        = $latest[$name].When.ToString('yyyy-MM-dd HH:mm')
                Elevated     = $doc.Metadata.Elevated
                ItspId       = $r.ItspId
                Title        = $r.Title
                CpcscLevel   = $r.CpcscLevel
                NistR2       = $r.NistR2
                Cmmc         = $r.Cmmc
                Check        = $r.Check
                Status       = $r.Status
                Actual       = $r.Actual
            })
    }
}

if (-not (Test-Path -Path $OutputPath)) { $null = New-Item -Path $OutputPath -ItemType Directory -Force }
$rows | Export-Csv -Path (Join-Path $OutputPath 'fleet-summary.csv') -NoTypeInformation -Encoding UTF8

# Matrix: check x computer
$computers = @($latest.Keys | Sort-Object)
$checks = $rows | Select-Object ItspId, Check -Unique | Sort-Object ItspId, Check
$lookup = @{}
foreach ($r in $rows) { $k = '{0}|{1}|{2}' -f $r.ComputerName, $r.ItspId, $r.Check; if (-not $lookup.ContainsKey($k)) { $lookup[$k] = $r.Status } }
$matrix = foreach ($c in $checks) {
    $o = [ordered]@{ ItspId = $c.ItspId; Check = $c.Check }
    foreach ($pc in $computers) {
        $k = '{0}|{1}|{2}' -f $pc, $c.ItspId, $c.Check
        $o[$pc] = if ($lookup.ContainsKey($k)) { $lookup[$k] } else { '' }
    }
    [pscustomobject]$o
}
$matrix | Export-Csv -Path (Join-Path $OutputPath 'fleet-matrix.csv') -NoTypeInformation -Encoding UTF8

# Per-requirement counts
$byReq = $rows | Group-Object ItspId | Sort-Object Name | ForEach-Object {
    $g = $_.Group
    [pscustomobject][ordered]@{
        ItspId = $_.Name
        Title  = ($g | Select-Object -First 1).Title
        Level  = ($g | Select-Object -First 1).CpcscLevel
        Pass   = @($g | Where-Object Status -eq 'PASS').Count
        Fail   = @($g | Where-Object Status -eq 'FAIL').Count
        Warn   = @($g | Where-Object Status -eq 'WARN').Count
        Manual = @($g | Where-Object Status -eq 'MANUAL').Count
        Error  = @($g | Where-Object Status -eq 'ERROR').Count
        FailingComputers = (@($g | Where-Object Status -eq 'FAIL' | Select-Object -ExpandProperty ComputerName -Unique) -join ', ')
    }
}

$enc = { param($t) [System.Net.WebUtility]::HtmlEncode([string]$t) }
$tr = foreach ($b in $byReq) {
    "<tr><td class='mono'>$(& $enc $b.ItspId)</td><td>$(& $enc $b.Title)<div class='sub'>CPCSC Level $($b.Level)</div></td><td class='n ok'>$($b.Pass)</td><td class='n bad'>$($b.Fail)</td><td class='n warn'>$($b.Warn)</td><td class='n man'>$($b.Manual)</td><td class='n'>$($b.Error)</td><td class='sub'>$(& $enc $b.FailingComputers)</td></tr>"
}
$notElevated = @($latest.Keys | Where-Object { -not $latest[$_].Doc.Metadata.Elevated })
$warnElev = if ($notElevated.Count -gt 0) { "<p class='alert'>Reports run without elevation (incomplete): $(& $enc ($notElevated -join ', '))</p>" } else { '' }
$html = @"
<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>CPCSC fleet summary</title>
<style>
:root{--bg:#121519;--sf:#181c22;--bd:#2c333d;--wh:#eaf0f5;--tx:#b7c0c9;--tx2:#8d98a3;--or:#df7a1e;--od:#9aa056;--rd:#e26a5d;--ok:#68d391}
body{background:var(--bg);color:var(--tx);font:14px/1.5 "IBM Plex Sans",Segoe UI,Arial,sans-serif;margin:0;padding:32px}
h1{color:var(--wh);font:700 34px/1.1 "Barlow Condensed",Segoe UI,Arial,sans-serif;margin:6px 0 4px}
.eb{font:12px "Share Tech Mono",Consolas,monospace;letter-spacing:.16em;text-transform:uppercase;color:var(--tx2)}.eb b{color:var(--or);font-weight:400}
table{width:100%;border-collapse:collapse;background:var(--sf);border:1px solid var(--bd);margin-top:16px}th,td{text-align:left;vertical-align:top;padding:9px 10px;border-bottom:1px solid var(--bd)}
th{color:var(--wh);font-weight:600;border-bottom:1px solid var(--or)}.sub{color:var(--tx2);font-size:12px}.mono{font-family:"Share Tech Mono",Consolas,monospace;color:var(--od)}
.n{text-align:right;font-family:"Share Tech Mono",Consolas,monospace}.ok{color:var(--ok)}.bad{color:var(--rd)}.warn{color:var(--or)}.man{color:var(--od)}.alert{color:var(--or)}
</style></head><body>
<div class="eb"><b>// </b>CPCSC readiness &middot; ITSP.10.171 fleet summary</div>
<h1>$($computers.Count) computers</h1>
<div class="sub">Newest report per computer from $(& $enc $ReportPath), merged $(Get-Date -Format 'yyyy-MM-dd HH:mm')</div>
$warnElev
<table><thead><tr><th>ITSP.10.171</th><th>Requirement</th><th>Pass</th><th>Fail</th><th>Warn</th><th>Manual</th><th>Error</th><th>Failing computers</th></tr></thead><tbody>
$($tr -join "`n")
</tbody></table>
<p class="sub">Counts are checks, not computers; a requirement with several checks counts each one. Details per computer are in fleet-summary.csv and fleet-matrix.csv. This summary is readiness evidence, not a CPCSC assessment.</p>
</body></html>
"@
Set-Content -Path (Join-Path $OutputPath 'fleet-summary.html') -Value $html -Encoding UTF8
Write-Host ("Merged {0} computers. Output in {1}" -f $computers.Count, $OutputPath)
