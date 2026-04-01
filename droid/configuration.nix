{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";

  android-integration = {
    am.enable                    = true;
    termux-setup-storage.enable  = true;
    termux-open.enable           = true;
    termux-open-url.enable       = true;
    xdg-open.enable              = true;
  };

  environment.packages = with pkgs; [
    git
    curl
    wget
    ripgrep
    fd
    eza
    bat
    fzf
    zoxide
    jq
    micro
    nix-output-monitor
  ];

  home-manager = {
    useGlobalPkgs       = true;
    useUserPackages     = true;
    backupFileExtension = "hm-bak";
    config              = import ../home/szlacroxx/home.nix;
  };

  terminal = {
    font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf";
  };

  user.shell = "${pkgs.zsh}/bin/zsh";
}
