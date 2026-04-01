{ pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # Nix settings
  # ---------------------------------------------------------------------------
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users         = [ "root" "szlacroxx" ];
    # Binary caches
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBw="
    ];
  };

  # Automatic garbage collection — keep 7 days, run weekly
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  # Deduplicate identical store paths with hard links
  nix.optimise.automatic = true;

  # ---------------------------------------------------------------------------
  # Locale
  # ---------------------------------------------------------------------------
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME      = "pl_PL.UTF-8";
      LC_MONETARY  = "pl_PL.UTF-8";
      LC_PAPER     = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
    };
  };

  console.keyMap = "pl";

  # ---------------------------------------------------------------------------
  # SSH daemon
  # ---------------------------------------------------------------------------
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin        = "no";
      X11Forwarding          = false;
    };
  };

  # Open SSH port in firewall
  networking.firewall.allowedTCPPorts = [ 22 ];

  environment.systemPackages = with pkgs; [
  	git curl wget btop ripgrep fd eza bat fzf micro
  	pkgs."nix-output-monitor"
  	pkgs."docker-compose"
  	pkgs."nix-tree"
	direnv
  	zoxide
  	tldr
  	jq yq
  	gh
  	fastfetch
  	tree
  	brave
  ];

}
