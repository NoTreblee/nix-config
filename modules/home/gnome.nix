{ pkgs, lib, ... }:

{
  # ---------------------------------------------------------------------------
  # GTK theme
  # ---------------------------------------------------------------------------
  gtk = {
    enable = true;
    theme = {
      name    = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme.name = "Adwaita";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # ---------------------------------------------------------------------------
  # Extensions & related packages
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    papirus-icon-theme
    adw-gtk3
  ];

  # ---------------------------------------------------------------------------
  # dconf settings
  # ---------------------------------------------------------------------------
  dconf.settings = {

    # -- Interface ------------------------------------------------------------
    "org/gnome/desktop/interface" = {
      color-scheme        = "prefer-dark";
      gtk-theme           = "adw-gtk3-dark";
      icon-theme          = "Papirus-Dark";
      cursor-theme        = "Adwaita";
      cursor-size         = lib.hm.gvariant.mkInt32 24;
      font-name           = "Inter 11";
      document-font-name  = "Inter 11";
      monospace-font-name = "FiraCode Nerd Font Mono 11";
      text-scaling-factor = 1.0;
      font-antialiasing   = "rgba";
      font-hinting        = "slight";
    };

    # -- Shell ----------------------------------------------------------------
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "appindicatorsupport@rgcjonas.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.TextEditor.desktop"
      ];
    };

    # -- Dash to Dock ---------------------------------------------------------
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position       = "BOTTOM";
      extend-height       = false;
      dock-fixed          = false;
      autohide            = true;
      intellihide         = true;
      show-trash          = true;
      show-mounts         = false;
      transparency-mode   = "DYNAMIC";
    };

    # -- Blur My Shell --------------------------------------------------------
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.75;
      sigma      = 30;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur       = true;
      brightness = 0.6;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
    };

    # -- Window manager -------------------------------------------------------
    "org/gnome/desktop/wm/preferences" = {
      button-layout  = "appmenu:minimize,maximize,close";
      focus-mode     = "click";
      num-workspaces = 4;
    };

    # -- Keybindings ----------------------------------------------------------
    "org/gnome/desktop/wm/keybindings" = {
      close                  = [ "<Super>q"        ];
      maximize               = [ "<Super>Up"        ];
      unmaximize             = [ "<Super>Down"      ];
      switch-to-workspace-1  = [ "<Super>1"         ];
      switch-to-workspace-2  = [ "<Super>2"         ];
      switch-to-workspace-3  = [ "<Super>3"         ];
      switch-to-workspace-4  = [ "<Super>4"         ];
      move-to-workspace-1    = [ "<Super><Shift>1"  ];
      move-to-workspace-2    = [ "<Super><Shift>2"  ];
      move-to-workspace-3    = [ "<Super><Shift>3"  ];
      move-to-workspace-4    = [ "<Super><Shift>4"  ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home         = [ "<Super>e" ];
      screensaver  = [ "<Super>l" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    # Super+Enter → GNOME Console
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name    = "Terminal";
      command = "kgx";
      binding = "<Super>Return";
    };

    # -- Mutter (compositor) --------------------------------------------------
    "org/gnome/mutter" = {
      dynamic-workspaces       = false;
      workspaces-only-on-primary = true;
      # Enables fractional scaling — useful for HiDPI displays (e.g. mbp Retina)
      # Set scale via Settings → Displays after enabling
      experimental-features    = [ "scale-monitor-framebuffer" ];
    };

    # -- Touchpad -------------------------------------------------------------
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click              = true;
      natural-scroll            = true;
      two-finger-scrolling-enabled = true;
    };

    # -- Night light ----------------------------------------------------------
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled          = true;
      night-light-temperature      = lib.hm.gvariant.mkUint32 4000;
      night-light-schedule-automatic = true;
    };

    # -- Privacy --------------------------------------------------------------
    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
    };
  };
}
