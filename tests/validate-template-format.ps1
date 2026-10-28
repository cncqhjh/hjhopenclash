$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$templates = @('Clash-hjhFull.ini', 'Clash-cncqhjh.ini')

foreach ($name in $templates) {
    $lines = Get-Content -LiteralPath (Join-Path $root $name)
    $firstContentLine = $lines | Where-Object { $_.Trim() } | Select-Object -First 1
    if ($firstContentLine.Trim() -ne '[custom]') {
        throw "$name must begin with the [custom] section required by subconverter"
    }
}

'TEMPLATE_FORMAT_VALIDATION_OK'
