# convert_alpha.ps1

$tracks = @{
    "Sweden"              = "calm1.ogg"
    "Clark"               = "calm2.ogg"
    "Minecraft"           = "calm3.ogg"
    "Subwoofer Lullaby"   = "hal1.ogg"
    "Living Mice"         = "hal2.ogg"
    "Moog City"           = "hal3.ogg"
    "Haggstrom"           = "nuance1.ogg"
    "Mice on Venus"       = "piano1.ogg"
    "Danny"               = "creative1.ogg"
    "Key"                 = "creative2.ogg"
    "Oxygène"             = "creative3.ogg"
    "Chris"               = "end.ogg"
    "Dry Hands"           = "13.ogg"
    "Wet Hands"           = "cat.ogg"
    "Thirteen"            = "blocks.ogg"
}

$outputDir = "converted"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

foreach ($track in $tracks.Keys) {
    $input1 = "mp3s\$track.mp3"
    $output = Join-Path $outputDir $tracks[$track]

    if (Test-Path $input1) {
        Write-Host "Converting $input1 -> $output"
        ffmpeg -y -i "$input1" -c:a libvorbis -qscale:a 5 "$output"
    } else {
        Write-Warning "Missing: $input1"
    }
}
