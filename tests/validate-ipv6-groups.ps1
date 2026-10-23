$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$templates = @('Clash-hjhFull.ini', 'Clash-cncqhjh.ini')
$candidatePattern = '^(?!.*(剩余|到期|重置|流量|套餐|官网|时间)).*$'

foreach ($template in $templates) {
    $body = Get-Content -LiteralPath (Join-Path $root $template) -Raw
    $expected = "custom_proxy_group=🌐 IPv6-手动``select``$candidatePattern``[]REJECT"

    if (-not $body.Contains($expected)) {
        throw "$template IPv6 manual group does not include the same candidates as IPv6 auto detection"
    }
}

Write-Output 'IPV6_GROUP_VALIDATION_OK'
