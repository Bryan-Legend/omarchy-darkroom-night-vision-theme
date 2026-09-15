# Darkroom Night Vision for VS Code

Red-only color theme built from the palette in
[omarchy-darkroom-night-vision-theme](https://github.com/Bryan-Legend/omarchy-darkroom-night-vision-theme).
Every color keeps its green and blue channels at 00. Backgrounds are true
black, so it looks best on OLED screens.

## Install

From this folder:

```bash
npx @vscode/vsce package -o darkroom-night-vision.vsix
code --install-extension darkroom-night-vision.vsix
```

Then pick **Darkroom Night Vision** with `Ctrl+K Ctrl+T`.

Remove it with `code --uninstall-extension bryan-legend.darkroom-night-vision`.
