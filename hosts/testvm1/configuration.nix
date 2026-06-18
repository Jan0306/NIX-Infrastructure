{ config, pkgs, ... }:

let
  hosts = import ../../lib/hosts.nix;
  host = hosts.testvm1;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/users.nix
    ];

  networking.hostName = host.hostname;
  networking.interfaces.ens18.useDHCP = false;
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = host.ip;
      prefixLength = 24;
    }
  ];

  #  Set the default gateway and DNS nameservers
  networking = {
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" "8.8.8.8" ];
  };

  services.qemuGuest.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "26.05";
}