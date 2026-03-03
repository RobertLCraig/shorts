# prefetch_audio.ps1
# Downloads all audio library files from incompetech.com to audio/library/
# Run from the project root: .\prefetch_audio.ps1

$targetDir = Join-Path $PSScriptRoot "audio\library"
if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Created directory: $targetDir"
}

$tracks = @(
    @{ Name = "Monkeys Spinning Monkeys";   File = "Monkeys Spinning Monkeys.mp3" }
    @{ Name = "Local Forecast - Elevator";  File = "Local Forecast - Elevator.mp3" }
    @{ Name = "Upbeat Forever";             File = "Upbeat Forever.mp3" }
    @{ Name = "Mining by Moonlight";        File = "Mining by Moonlight.mp3" }
    @{ Name = "Sneaky Snitch";              File = "Sneaky Snitch.mp3" }
    @{ Name = "After Lemons";              File = "After Lemons.mp3" }
    @{ Name = "Carefree";                   File = "Carefree.mp3" }
    @{ Name = "Fluffing a Duck";            File = "Fluffing a Duck.mp3" }
    @{ Name = "Wholesome";                  File = "Wholesome.mp3" }
    @{ Name = "Impact Prelude";             File = "Impact Prelude.mp3" }
    @{ Name = "Cipher";                     File = "Cipher.mp3" }
    @{ Name = "Pixelland";                  File = "Pixelland.mp3" }
)

$baseUrl = "https://incompetech.com/music/royalty-free/mp3-royaltyfree"
$total = $tracks.Count
$downloaded = 0
$skipped = 0
$failed = 0

foreach ($track in $tracks) {
    $dest = Join-Path $targetDir $track.File
    $encodedFile = [Uri]::EscapeDataString($track.File)
    $url = "$baseUrl/$encodedFile"

    if (Test-Path $dest) {
        Write-Host "  SKIP  $($track.Name) (already exists)" -ForegroundColor DarkGray
        $skipped++
        continue
    }

    Write-Host "  DOWN  $($track.Name)..." -ForegroundColor Cyan -NoNewline
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        $downloaded++
        Write-Host " OK" -ForegroundColor Green
    }
    catch {
        $failed++
        Write-Host " FAILED: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done! Downloaded: $downloaded | Skipped: $skipped | Failed: $failed" -ForegroundColor Yellow
