{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/niri.nix
  ];

  networking.hostName              = "mbp";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  users.users.szlacroxx = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "docker" "networkmanager" ];
    shell        = pkgs.zsh;
  };

  programs.zsh.enable        = true;
  nixpkgs.config.allowUnfree = true;

  # ---------------------------------------------------------------------------
  # HiDPI — MacBook Pro 13" Retina (2560x1600)
  # Fractional scaling is enabled globally via the gnome module.
  # Set preferred scale in Settings → Displays (e.g. 150% or 175%).
  # GDK_SCALE=2 makes the GDM login screen readable on the Retina panel.
  # ---------------------------------------------------------------------------
  environment.variables = {
#    GDK_SCALE     = "2";
#    GDK_DPI_SCALE = "0.5";
  };

  system.stateVersion = "24.11";
}
