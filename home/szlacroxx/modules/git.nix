{ ... }:
{

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "NoTreblee";
        email = "fiercestword@gmail.com";
        
      };
      
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "micro";
	  gpg.format = "ssh";

    };
    
    signing = {
    	key = "~/.ssh/id_ed25519";
    	signByDefault = true;

    };
  };
  
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      side-by-side = true;
      line-numbers = true;

    };
  };
}
