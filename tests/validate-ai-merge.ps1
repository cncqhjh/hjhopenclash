param([switch]$AllowLegacyAlias)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$aiPath = Join-Path $root 'AI.list'
$templates = @(
    (Join-Path $root 'Clash-hjhFull.ini'),
    (Join-Path $root 'Clash-cncqhjh.ini')
)

$requiredRules = @(
    'DOMAIN-SUFFIX,meta.ai',
    'DOMAIN-SUFFIX,metademolab.com',
    'DOMAIN-SUFFIX,perplexity.ai',
    'DOMAIN-SUFFIX,hcaptcha.com',
    'DOMAIN-SUFFIX,hcaptchausercontent.com',
    'IP-CIDR,74.125.250.0/24,no-resolve',
    'DOMAIN-SUFFIX,google.com'
)

$rules = @(Get-Content -LiteralPath $aiPath | Where-Object {
    $_.Trim() -and -not $_.Trim().StartsWith('#')
})

foreach ($rule in $requiredRules) {
    if ($rules -notcontains $rule) { throw "AI.list missing: $rule" }
}
if (@($rules | Group-Object | Where-Object Count -gt 1).Count -ne 0) {
    throw 'AI.list contains duplicate rules'
}

foreach ($template in $templates) {
    $body = Get-Content -LiteralPath $template -Raw
    if ($body -notmatch 'ruleset=✨ AI,https://raw\.githubusercontent\.com/cncqhjh/hjhopenclash/refs/heads/main/AI\.list') {
        throw "$template does not use the merged AI ruleset"
    }
    if ($body -notmatch 'custom_proxy_group=✨ AI`select`\[\]美国-自动') {
        throw "$template does not define the merged AI selector"
    }
    if ($body -match 'custom_proxy_group=✨ AI`select`[^\r\n]*\[\]DIRECT') {
        throw "$template allows DIRECT in the merged AI selector"
    }
    if ($body -match 'AI2|👽 AI') { throw "$template still contains AI2 or the old emoji" }

    $aliasCount = @([regex]::Matches($body, 'custom_proxy_group=✨ AI1`select`\[\]✨ AI')).Count
    if ($AllowLegacyAlias) {
        if ($aliasCount -ne 1) { throw "$template must contain one compatibility alias" }
    } elseif ($body -match 'AI1') {
        throw "$template still contains AI1"
    }
}

if (-not $AllowLegacyAlias -and (Test-Path -LiteralPath (Join-Path $root 'AI2.list'))) {
    throw 'AI2.list still exists'
}

'AI_MERGE_VALIDATION_OK'
