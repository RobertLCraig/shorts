# build_audio_library.ps1
# Scans the audio/library directory (including subdirectories like Licenced/)
# Finds .mp3, .wav, .m4a files. If a .txt file is present in the same directory,
# it reads it to use as the attribution text.
# Outputs to audio/library.js so it can be loaded locally without CORS issues.

$libraryDir = Join-Path $PSScriptRoot "audio\library"
$outputFile = Join-Path $PSScriptRoot "audio\library.js"

if (!(Test-Path $libraryDir)) {
    Write-Host "Audio library directory not found: $libraryDir" -ForegroundColor Red
    exit 1
}

$audioFiles = Get-ChildItem -Path $libraryDir -Include *.mp3, *.wav, *.m4a -Recurse -File

$tracks = @()

foreach ($file in $audioFiles) {
    # Calculate relative URL path (replace backslashes with forward slashes)
    $relativePath = $file.FullName.Substring($PSScriptRoot.Length + 1).Replace('\', '/')
    
    # Check for a license .txt file in the same directory
    $dir = $file.DirectoryName
    $txtFiles = Get-ChildItem -Path $dir -Filter *.txt -File
    
    $attribution = ""
    if ($txtFiles.Count -gt 0) {
        # Just use the first .txt file found
        $txtFile = $txtFiles[0]
        $content = Get-Content $txtFile.FullName -Raw
        $attribution = $content.Trim()
    }
    else {
        # Fallback for the incompetech ones we just downloaded into the root of audio/library/
        if ($file.DirectoryName -eq $libraryDir) {
            $nameWithoutExt = $file.BaseName
            $attribution = "$nameWithoutExt by Kevin MacLeod (incompetech.com)`nLicensed under Creative Commons: By Attribution 4.0`nhttp://creativecommons.org/licenses/by/4.0/"
        }
    }
    
    # Determine basic metadata
    # The user's new file is e.g. "starostin-comedy-cartoon-funny-background-music-492540.mp3"
    $name = $file.BaseName.Replace('-', ' ')
    $author = 'Unknown'
    $genre = 'Library'
    
    # Try to parse author if it's the Pixabay format (e.g. author-title-id.mp3)
    if ($file.Directory.Name -ne "library") {
        $genre = "Licenced"
        # Often the directory name is a cleaner title for Licensed items
        $name = $file.Directory.Name
    }
    else {
        $author = 'Kevin MacLeod'
        $genre = 'Upbeat' # Defaulting to Upbeat for the Kevin MacLeod ones
    }

    $tracks += @{
        name        = $name
        author      = $author
        genre       = $genre
        url         = $relativePath
        attribution = $attribution
    }
}

# Convert to JSON
$json = $tracks | ConvertTo-Json -Depth 5

# Create the JS wrapper
$jsContent = "window.AUDIO_LIBRARY_DATA = $json;"

# Save to file
Set-Content -Path $outputFile -Value $jsContent -Encoding UTF8

Write-Host "Successfully built library.js with $($tracks.Count) tracks." -ForegroundColor Green
