{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/cups.nix
    ./modules/ssh.nix
    ./modules/git.nix
    ./modules/packages.nix
    ../../modules/home/gnome.nix
    ../../modules/home/niri.nix
  ];

  home.username      = "szlacroxx";
  home.homeDirectory = "/home/szlacroxx";

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
