# THIS FILE IS A PLACEHOLDER.
#
# Generate the real hardware-configuration by running on snus:
#
#   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
#
# Then commit the result to the repo and remove this comment block.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ---------------------------------------------------------------------------
  # Boot
  # ---------------------------------------------------------------------------
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules          = [];
  boot.kernelModules                 = [ "kvm-intel" ];  # swap for kvm-amd if needed
  boot.extraModulePackages           = [];

  boot.loader.systemd-boot.enable   = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ---------------------------------------------------------------------------
  # Filesystems — replace with output from nixos-generate-config
  # ---------------------------------------------------------------------------
  fileSystems."/" = {
    device  = "/dev/disk/by-label/nixos";
    fsType  = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [];

  # ---------------------------------------------------------------------------
  # Hardware
  # ---------------------------------------------------------------------------
  nixpkgs.hostPlatform        = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
