{ config, pkgs, ... }:

let
  hosts = import ../../lib/hosts.nix;
  host = hosts.clients.macbookair;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ./firmware.tar;

      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];

  hardware.enableRedistributableFirmware = true;

  networking.hostName = host.hostname;

  services.blueman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    "brcmfmac"
    "btusb"
  ];

  boot.kernelParams = [
    "pcie_aspm=off"
  ];

  environment.systemPackages = with pkgs; [
    
  ];

  system.stateVersion = "26.05";
}
