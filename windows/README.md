# Darkroom Night Vision for Windows

> *Live like you're driving the Keck telescopes.*

A Windows port of the [Omarchy theme](../README.md): dark mode, a red accent,
the red-only astronomy wallpapers, and a red Windows Terminal color scheme.

## Install

From the repo folder, in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
```

This will:

- copy the wallpapers to `%LOCALAPPDATA%\DarkroomNightVision`,
- add the **Darkroom Night Vision** scheme to Windows Terminal (as a settings
  fragment) and use it for Windows PowerShell, Command Prompt, and PowerShell 7,
- apply a Windows theme with dark mode, a `#D40000` accent, and the *Pillars of
  Creation* wallpaper. Windows opens Settings while it applies the theme.

Restart Windows Terminal afterwards. The other wallpapers are in
`%LOCALAPPDATA%\DarkroomNightVision\backgrounds` — pick them in
**Settings › Personalization › Background**.

To remove it:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\install.ps1 -Uninstall
```

Then choose another theme in **Settings › Personalization › Themes**.

## Night-vision notes

A theme only changes Windows' own chrome: title bars, Start, the taskbar
accent, and the terminal. Apps like browsers and File Explorer's content area
keep their normal colors, and Windows has no built-in red-only screen filter.
For a red screen everywhere, [f.lux](https://justgetflux.com) has a
**Darkroom** mode that inverts the display into red on black.
