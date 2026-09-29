# Darkroom Night Vision - Windows installer
# Copies the Pillars of Creation wallpaper to where the theme expects it,
# then applies the contrast theme.
$ErrorActionPreference = 'Stop'

$repo = Split-Path $PSScriptRoot
$dir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Themes\DarkroomNightVision'
New-Item -ItemType Directory -Force $dir | Out-Null
Copy-Item (Join-Path $repo 'backgrounds\00-pillars-of-creation-ccw.png') (Join-Path $dir 'pillars-of-creation.png')

Invoke-Item (Join-Path $PSScriptRoot 'darkroom-night-vision.theme')
