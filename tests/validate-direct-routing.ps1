$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$templates = @('Clash-hjhFull.ini', 'Clash-cncqhjh.ini')
$domain = 'hdsky.me'

function Test-DomainRule([string]$rule, [string]$target) {
    $parts = $rule.Split(',')
    if ($parts.Count -lt 2) { return $false }
    if ($parts[0] -eq 'DOMAIN') { return $target -eq $parts[1] }
    if ($parts[0] -eq 'DOMAIN-SUFFIX') {
        return $target -eq $parts[1] -or $target.EndsWith(".$($parts[1])")
    }
    return $false
}

foreach ($template in $templates) {
    $matchedPolicy = $null
    foreach ($line in Get-Content -LiteralPath (Join-Path $root $template)) {
        if (-not $line.StartsWith('ruleset=')) { continue }
        $policy, $source = $line.Substring(8).Split(',', 2)

        if ($source.StartsWith('[]')) {
            if (Test-DomainRule $source.Substring(2) $domain) {
                $matchedPolicy = $policy
                break
            }
            continue
        }

        if ($source -notmatch 'raw\.githubusercontent\.com/cncqhjh/hjhopenclash/(?:refs/heads/)?main/(.+)$') {
            continue
        }
        $listPath = Join-Path $root ($Matches[1] -replace '/', '\')
        if (-not (Test-Path -LiteralPath $listPath)) { continue }
        foreach ($rule in Get-Content -LiteralPath $listPath) {
            if (Test-DomainRule $rule.Trim() $domain) {
                $matchedPolicy = $policy
                break
            }
        }
        if ($null -ne $matchedPolicy) { break }
    }

    if ($matchedPolicy -ne 'DIRECT') {
        throw "$template routes $domain to '$matchedPolicy' instead of DIRECT"
    }
}

'DIRECT_ROUTING_VALIDATION_OK'
