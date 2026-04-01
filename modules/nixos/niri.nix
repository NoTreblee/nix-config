{ pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # niri — scrollable-tiling Wayland compositor
  # ---------------------------------------------------------------------------
  programs.niri.enable = true;

  # ---------------------------------------------------------------------------
  # DankMaterialShell — shell layer for niri (and other Wayland compositors)
  # Requires nixos-unstable. After first boot run: dms setup
  # ---------------------------------------------------------------------------
  programs.dms-shell = {
    enable = true;

    systemd = {
      enable            = true;
      restartIfChanged  = true;
    };

    enableSystemMonitoring = true;
    enableDynamicTheming   = true;
    enableAudioWavelength  = true;
    enableClipboardPaste   = true;
  };

  # ---------------------------------------------------------------------------
  # Runtime packages for the niri session
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    cliphist       # clipboard history (used by DMS clipboard widget)
    wl-clipboard   # wl-copy / wl-paste
    xdg-utils      # xdg-open
    brightnessctl  # backlight control
    playerctl      # MPRIS media key support
    grim           # screenshot backend
    slurp          # region selection for screenshots
    libnotify      # notify-send
  ];
}
