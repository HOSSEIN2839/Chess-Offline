$ErrorActionPreference = "Stop"

$Root = $PSScriptRoot
$Work = Join-Path $Root ".dependency-work"
$Vendor = Join-Path $Root "vendor"

New-Item -ItemType Directory -Path $Work -Force | Out-Null
New-Item -ItemType Directory -Path $Vendor -Force | Out-Null

Push-Location $Work

try {
    Write-Host "Installing npm dependencies..." -ForegroundColor Cyan

    npm install --no-audit --no-fund chess.js@1.4.0 stockfish@19.0.1

    if ($LASTEXITCODE -ne 0) {
        throw "npm installation failed."
    }

    $Chess = Join-Path $Work "node_modules\chess.js\dist\esm\chess.js"

    if (!(Test-Path $Chess)) {
        throw "chess.js file was not found."
    }

    Copy-Item $Chess (Join-Path $Vendor "chess.js") -Force

    $StockfishPackage = Join-Path $Work "node_modules\stockfish"

    $Engine = Get-ChildItem $StockfishPackage -Recurse -File |
        Where-Object { $_.Name -eq "stockfish-19-single.js" } |
        Select-Object -First 1

    if (!$Engine) {
        throw "Stockfish single-thread engine was not found."
    }

    $WasmName = "stockfish-19-single.wasm"
    $Wasm = Get-ChildItem $StockfishPackage -Recurse -File |
        Where-Object { $_.Name -eq $WasmName } |
        Select-Object -First 1

    if (!$Wasm) {
        throw "Stockfish WASM file was not found."
    }

    Copy-Item $Engine.FullName (Join-Path $Vendor "stockfish.js") -Force
    Copy-Item $Wasm.FullName (Join-Path $Vendor $WasmName) -Force

    Write-Host "Dependencies copied successfully." -ForegroundColor Green
    Get-ChildItem $Vendor
}
finally {
    Pop-Location
}
