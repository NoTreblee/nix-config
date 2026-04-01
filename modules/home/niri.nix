{ lib, ... }:

{
  # ---------------------------------------------------------------------------
  # niri configuration (KDL format)
  # DMS-managed files (dms/colors.kdl etc.) are created as empty placeholders
  # by the activation script and populated by 'dms setup' on first login.
  # ---------------------------------------------------------------------------
  xdg.configFile."niri/config.kdl".text = ''
    environment {
      XDG_CURRENT_DESKTOP         "niri"
      QT_QPA_PLATFORM             "wayland"
      ELECTRON_OZONE_PLATFORM_HINT "auto"
      QT_QPA_PLATFORMTHEME        "gtk3"
      QT_QPA_PLATFORMTHEME_QT6    "gtk3"
    }

    layout {
      gaps 5
      background-color "transparent"
    }

    // DMS-managed files — populated by 'dms setup', do not edit manually
    include "dms/colors.kdl"
    include "dms/layout.kdl"
    include "dms/alttab.kdl"
    include "dms/binds.kdl"

    // Place DMS shell on the overview backdrop
    layer-rule {
      match namespace="^quickshell$"
      place-within-backdrop true
    }
    layer-rule {
      match namespace="dms:blurwallpaper"
      place-within-backdrop true
    }

    // Window rules
    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
    }
    window-rule {
      match app-id=r#"^org\.gnome\."#
      draw-border-with-background false
      geometry-corner-radius 12
      clip-to-geometry true
    }
    window-rule {
      match app-id="Alacritty"
      draw-border-with-background false
    }
    window-rule {
      match is-active=false
      opacity 0.9
    }
    window-rule {
      match app-id=r#"org\.quickshell$"#
      open-floating true
    }

    binds {
      // Window management
      Mod+Q { close-window; }
      Mod+Return hotkey-overlay-title="Terminal" { spawn "alacritty"; }
      Mod+E hotkey-overlay-title="Files" { spawn "nautilus"; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+C { center-column; }

      // Focus movement (vim-style)
      Mod+H { focus-column-left; }
      Mod+L { focus-column-right; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }

      // Window movement
      Mod+Shift+H { move-column-left; }
      Mod+Shift+L { move-column-right; }
      Mod+Shift+J { move-window-down; }
      Mod+Shift+K { move-window-up; }

      // Workspaces
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }

      // DMS — application launchers
      Mod+Space hotkey-overlay-title="Launcher" {
        spawn "dms" "ipc" "call" "spotlight" "toggle";
      }
      Mod+V hotkey-overlay-title="Clipboard" {
        spawn "dms" "ipc" "call" "clipboard" "toggle";
      }
      Mod+M hotkey-overlay-title="Task Manager" {
        spawn "dms" "ipc" "call" "processlist" "focusOrToggle";
      }
      Mod+Comma hotkey-overlay-title="Settings" {
        spawn "dms" "ipc" "call" "settings" "focusOrToggle";
      }
      Mod+N hotkey-overlay-title="Notifications" {
        spawn "dms" "ipc" "call" "notifications" "toggle";
      }
      Mod+Y hotkey-overlay-title="Wallpapers" {
        spawn "dms" "ipc" "call" "dankdash" "wallpaper";
      }

      // DMS — lock
      Mod+Alt+L hotkey-overlay-title="Lock Screen" {
        spawn "dms" "ipc" "call" "lock" "lock";
      }

      // Screenshot
      Print { spawn "grim" "-g" "$(slurp)" "$(xdg-user-dir PICTURES)/screenshot-$(date +%Y%m%d-%H%M%S).png"; }

      // Audio
      XF86AudioRaiseVolume allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "increment" "3";
      }
      XF86AudioLowerVolume allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "decrement" "3";
      }
      XF86AudioMute allow-when-locked=true {
        spawn "dms" "ipc" "call" "audio" "mute";
      }

      // Brightness
      XF86MonBrightnessUp allow-when-locked=true {
        spawn "dms" "ipc" "call" "brightness" "increment" "5" "";
      }
      XF86MonBrightnessDown allow-when-locked=true {
        spawn "dms" "ipc" "call" "brightness" "decrement" "5" "";
      }
    }
  '';

  # Create empty DMS placeholder files so the includes above don't fail on
  # first build. 'dms setup' will populate them on first login.
  # Using activation (not xdg.configFile) so DMS can overwrite them freely.
  home.activation.createNiriDmsPlaceholders =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.config/niri/dms"
      for f in colors layout alttab binds; do
        if [ ! -f "$HOME/.config/niri/dms/$f.kdl" ]; then
          touch "$HOME/.config/niri/dms/$f.kdl"
        fi
      done
    '';
}
