{ pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # Display server + GDM
  # ---------------------------------------------------------------------------
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable  = true;
    wayland = true;
  };

  services.desktopManager.gnome.enable = true;

  # ---------------------------------------------------------------------------
  # Remove default GNOME bloat
  # ---------------------------------------------------------------------------
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-photos
    gnome-maps
    gnome-music
    gnome-weather
    epiphany   # GNOME Web
    totem      # Videos
    yelp       # Help
    geary      # Email
  ];

  # ---------------------------------------------------------------------------
  # System-level GNOME packages
  # ---------------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
  ];

  # ---------------------------------------------------------------------------
  # Fonts
  # ---------------------------------------------------------------------------
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      inter
    ];
    fontconfig.defaultFonts = {
      sansSerif  = [ "Inter"                    "Noto Sans"      ];
      monospace  = [ "FiraCode Nerd Font Mono"  "Noto Sans Mono" ];
      emoji      = [ "Noto Color Emoji"                          ];
    };
  };

  # ---------------------------------------------------------------------------
  # PipeWire audio (replaces PulseAudio)
  # ---------------------------------------------------------------------------
  hardware.pulseaudio.enable = false;
  security.rtkit.enable      = true;

  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };
}
