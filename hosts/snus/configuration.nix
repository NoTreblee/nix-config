{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/niri.nix
  ];

  networking.hostName              = "snus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  users.users.szlacroxx = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "docker" "networkmanager" ];
    shell        = pkgs.zsh;
  };

  programs.zsh.enable        = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
