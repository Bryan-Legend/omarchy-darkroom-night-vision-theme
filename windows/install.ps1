<#
.SYNOPSIS
  Installs the Darkroom Night Vision theme on Windows 10/11.

.DESCRIPTION
  - Copies the red-only wallpapers to %LOCALAPPDATA%\DarkroomNightVision.
  - Adds a Windows Terminal color scheme (as a settings fragment) and applies it
    to the Windows PowerShell, Command Prompt, and PowerShell 7 profiles.
  - Applies a Windows theme: dark mode, red accent color, Pillars of Creation
    wallpaper.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\windows\install.ps1

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\windows\install.ps1 -Uninstall
#>
[CmdletBinding()]
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$InstallDir = Join-Path $env:LOCALAPPDATA 'DarkroomNightVision'
$FragmentDir = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows Terminal\Fragments\DarkroomNightVision'

if ($Uninstall) {
  Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $FragmentDir, $InstallDir
  Write-Host 'Removed the Windows Terminal scheme and wallpapers.'
  Write-Host 'Pick another theme in Settings > Personalization > Themes.'
  return
}

# Wallpapers
$BackgroundsDir = Join-Path $InstallDir 'backgrounds'
New-Item -ItemType Directory -Force -Path $BackgroundsDir | Out-Null
Copy-Item -Force -Path (Join-Path $RepoRoot 'backgrounds\*.png') -Destination $BackgroundsDir

# Windows Terminal color scheme
New-Item -ItemType Directory -Force -Path $FragmentDir | Out-Null
Copy-Item -Force -Path (Join-Path $PSScriptRoot 'windows-terminal.json') `
  -Destination (Join-Path $FragmentDir 'darkroom-night-vision.json')

# Windows theme (.theme files expect CRLF line endings)
$Wallpaper = Join-Path $BackgroundsDir '00-pillars-of-creation-ccw.png'
$ThemeFile = Join-Path $InstallDir 'Darkroom Night Vision.theme'
$Theme = (Get-Content -Raw -Path (Join-Path $PSScriptRoot 'darkroom-night-vision.theme')).Replace('{{WALLPAPER}}', $Wallpaper)
$Theme = $Theme -replace "`r?`n", "`r`n"
[System.IO.File]::WriteAllText($ThemeFile, $Theme, [System.Text.Encoding]::Unicode)

Start-Process -FilePath $ThemeFile

Write-Host 'Installed Darkroom Night Vision.'
Write-Host 'Restart Windows Terminal to pick up the color scheme.'
