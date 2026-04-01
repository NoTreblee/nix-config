{ config, pkgs, ... }:

{
  programs.zsh = {
    enable           = true;
    enableCompletion = true;

    autosuggestion.enable     = true;
    syntaxHighlighting.enable = true;

    history = {
      size       = 10000;
      path       = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share      = true;
    };

    plugins = [
      {
        name = "zsh-history-substring-search";
        src  = pkgs."zsh-history-substring-search";
      }
    ];

    initContent = ''
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      if [[ -n $commands[fzf] ]]; then
        source <(fzf --zsh)
      fi

      eval "$(direnv hook zsh)"
    '';
  };

  programs.starship = {
    enable               = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".text = ''
    format = "$directory$git_branch$git_status$cmd_duration$character"

    [directory]
    truncation_length = 4
    truncation_symbol = "…/"

    [git_branch]
    symbol = " "

    [character]
    success_symbol = "[➜](bold green)"
    error_symbol   = "[✗](bold red)"
  '';
}
