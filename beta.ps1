# convert_beta.ps1

$tracks = @{
    "Alpha"         = "menu1.ogg"
    "Blind Spots"   = "nether1.ogg"
    "Taswell"       = "creative3.ogg"
    "Biome Fest"    = "creative2.ogg"
    "Mutation"      = "calm2.ogg"
    "Floating Trees"= "calm3.ogg"
    "The End"       = "end.ogg"
    "Kyoto"         = "underwater1.ogg"
}

$outputDir = "converted"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

foreach ($track in $tracks.Keys) {
    $input1 = "mp3s\$track.mp3"
    $output = Join-Path $outputDir $tracks[$track]
    Write-Host "Processing $input1..."
    if (Test-Path $input1) {
        Write-Host "Converting $input1 -> $output"
        ffmpeg -y -i "$input1" -c:a libvorbis -qscale:a 5 "$output"
    } else {
        Write-Warning "Missing: $input1"
    }
}
