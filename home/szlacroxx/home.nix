{ config, pkgs, lib, ... }:

let
  isDroid = builtins.pathExists /data/data/com.termux.nix;
in
{
  imports = [
    (if isDroid then ./modules/zsh-droid.nix else ./modules/zsh.nix)
    ./modules/git.nix
    ./modules/packages.nix
  ] ++ lib.optionals (!isDroid) [
    ../../modules/home/gnome.nix
    ../../modules/home/niri.nix
  ];

  home.username     = "szlacroxx";
  home.homeDirectory =
    if isDroid
    then "/data/data/com.termux.nix/files/home"
    else "/home/szlacroxx";

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
