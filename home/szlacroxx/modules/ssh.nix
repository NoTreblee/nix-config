{ ... }:
{
	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = true;
			PermitRootLogin		   = "no";
			X11Forwarding		   = false;
		};
	};
	networking.firewall.allowedTCPPorts = [
		22
	];
	programs.ssh.startAgent = true;
}
