{ pkgs, ... }:

{
  home.packages = with pkgs; [
    
#    kubectl k9s helm terraform terragrunt
    pkgs."docker-compose"
    awscli2
    
  ];
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;
}
