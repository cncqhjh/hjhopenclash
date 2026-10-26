$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$templates = @('Clash-hjhFull.ini', 'Clash-cncqhjh.ini')
$ipv6Fallback = 'ruleset=🌍 国外,[]IP-CIDR6,::/0,no-resolve'
$finalRule = 'ruleset=➡️ 国内,[]FINAL'

foreach ($template in $templates) {
    $lines = Get-Content -LiteralPath (Join-Path $root $template)
    $ipv6Index = [Array]::IndexOf($lines, $ipv6Fallback)
    $finalIndex = [Array]::IndexOf($lines, $finalRule)

    if ($ipv6Index -lt 0) {
        throw "$template does not route unmatched IPv6 traffic to 🌍 国外"
    }
    if ($finalIndex -lt 0 -or $ipv6Index -ge $finalIndex) {
        throw "$template must place the IPv6 fallback before FINAL"
    }
}

'IPV6_FALLBACK_ROUTING_VALIDATION_OK'
