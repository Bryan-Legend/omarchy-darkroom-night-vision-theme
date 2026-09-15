#!/bin/bash

# Optional extras for the Darkroom Night Vision Omarchy theme.
#
#   install.sh            Install the extras
#   install.sh uninstall  Remove them again
#
# Extras:
#   - GTK/libadwaita styling (Nautilus and other GNOME apps) that follows the
#     active Omarchy theme: ~/.config/gtk-{4.0,3.0}/gtk.css link to the current
#     theme's gtk-*.css, so other themes keep the stock GNOME look.
#   - A red-only Hyprland screen shader that is switched on while the Omarchy
#     screensaver runs (only when this theme is active).

set -euo pipefail

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
current_theme="$HOME/.local/state/omarchy/current/theme"
shader="$HOME/.config/hypr/shaders/darkroom-red.glsl"
watcher="$HOME/.local/bin/darkroom-screensaver-red"
autostart="$HOME/.config/hypr/autostart.lua"
autostart_line='o.launch_on_start("darkroom-screensaver-red")'

install_extras() {
  local version target
  for version in 4.0 3.0; do
    target="$HOME/.config/gtk-$version/gtk.css"
    mkdir -p "$(dirname "$target")"
    if [[ -e $target || -L $target ]] && [[ $(readlink "$target") != "$current_theme/gtk-$version.css" ]]; then
      echo "Skipping $target: it already exists and isn't ours" >&2
    else
      ln -sfn "$current_theme/gtk-$version.css" "$target"
    fi
  done

  install -Dm644 "$here/darkroom-red.glsl" "$shader"
  install -Dm755 "$here/darkroom-screensaver-red" "$watcher"

  if ! grep -qF "$autostart_line" "$autostart" 2>/dev/null; then
    printf '\n-- Darkroom Night Vision: red-only screen shader while the screensaver runs.\n%s\n' "$autostart_line" >>"$autostart"
  fi

  if ! pgrep -f 'bin/darkroom-screensaver-re[d]' >/dev/null; then
    hyprctl dispatch "hl.dsp.exec_cmd([[$watcher]])" >/dev/null
  fi

  echo "Installed. Restart GNOME apps (e.g. nautilus -q) to pick up the GTK styling."
}

uninstall_extras() {
  local version target
  for version in 4.0 3.0; do
    target="$HOME/.config/gtk-$version/gtk.css"
    if [[ -L $target && $(readlink "$target") == "$current_theme/gtk-$version.css" ]]; then
      rm "$target"
    fi
  done

  pkill -f 'bin/darkroom-screensaver-re[d]' || true
  hyprctl eval 'hl.config({ decoration = { screen_shader = "" } })' >/dev/null || true
  rm -f "$shader" "$watcher"

  if [[ -f $autostart ]]; then
    sed -i '/-- Darkroom Night Vision: red-only screen shader while the screensaver runs./d' "$autostart"
    sed -i "\|^${autostart_line//\"/\\\"}\$|d" "$autostart"
  fi

  echo "Removed."
}

case "${1:-install}" in
install) install_extras ;;
uninstall) uninstall_extras ;;
*)
  echo "Usage: $0 [install|uninstall]" >&2
  exit 1
  ;;
esac
