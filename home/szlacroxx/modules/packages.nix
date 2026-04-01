{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # basics
    git curl wget htop ripgrep fd eza bat fzf micro

    # devops / cloud
    # kubectl k9s helm terraform terragrunt
    docker-compose
    awscli2

    # nix
    nix-output-monitor
    nix-tree
    direnv

    # utils
    zoxide
    tldr
    jq yq
    gh
  ];

  programs.zoxide.enable = true;
  programs.eza.enable    = true;
  programs.bat.enable    = true;
  programs.fzf.enable    = true;
}
