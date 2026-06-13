{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/users.nix
      ../../../hosts.nix
    ];

  networking = {
    hostName = hosts.testvm1.hostname;
    interfaces.enp0s3.useDHCP = false;
    interfaces.enp0s3.ipAddress = hosts.testvm1.ip;
  };

  services.qemuGuest.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "testvm1";

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "26.05";
}