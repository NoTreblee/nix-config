{ ... }:

{
  programs.git = {
    enable = true;
    userName = "NoTreblee";
    userEmail = "fiercestword@gmail.com"; 

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "micro";
    };

    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };
  };
}
