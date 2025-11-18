# copy_files.ps1

$convertedPath = Join-Path $PSScriptRoot "converted"
$packRoot = Join-Path $PSScriptRoot "mod\sounds"

$musicGame       = Join-Path $packRoot "music\game"
$musicNether     = Join-Path $packRoot "music\nether"
$musicEnd        = Join-Path $packRoot "music\end"
$musicUnderwater = Join-Path $packRoot "music\underwater"
$records         = Join-Path $packRoot "records"

# Create all directories if missing
$folders = @($musicGame, $musicNether, $musicEnd, $musicUnderwater, $records)
foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
    }
}

# Route files based on name
Get-ChildItem -Path $convertedPath -Filter *.ogg | ForEach-Object {
    $file = $_.Name
    $src = $_.FullName
    $dest = $null

    switch -Wildcard ($file) {
        "calm*.ogg" {
            $dest = Join-Path $musicGame $file
            break
        }
        "hal*.ogg" {
            $dest = Join-Path $musicGame $file
            break
        }
        "nuance*.ogg" {
            $dest = Join-Path $musicGame $file
            break
        }
        "piano*.ogg" {
            $dest = Join-Path $musicGame $file
            break
        }
        "creative*.ogg" {
            $dest = Join-Path $musicGame $file
            break
        }
        "nether*.ogg" {
            $dest = Join-Path $musicNether $file
            break
        }
        "underwater*.ogg" {
            $dest = Join-Path $musicUnderwater $file
            break
        }
        "end.ogg" {
            $dest = Join-Path $musicEnd $file
            break
        }
        { $_ -in @("13.ogg", "cat.ogg", "blocks.ogg") } {
            $dest = Join-Path $records $file
            break
        }
        default {
            $dest = Join-Path $musicGame $file
        }
    }

    Write-Host "Copying $file to $dest"
    Copy-Item -Path $src -Destination $dest -Force
}
# Build .mcpack
$mcpackName = "MyMusicPack.zip"
$mcpackPath =   $mcpackName

if (Test-Path $mcpackPath) {
    Remove-Item $mcpackPath -Force
}

Write-Host "`nPacking resource pack to $mcpackName..."
Compress-Archive -Path "mod\*" -DestinationPath $mcpackPath

Write-Host "✅ Done! Pack created: $mcpackName"
Move-Item $mcpackName 
Rename-Item -Path $mcpackName  -NewName "MyMusicPack1.mcpack"
