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

  # Network
  networking.hostName = host.hostname;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    "brcmfmac"
    "btusb"
  ];

  # Wichtig für BCM4377 Stabilität
  boot.kernelParams = [
    "pcie_aspm=off"
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # System Packages
  environment.systemPackages = with pkgs; [
    vscodium
    brave
    onlyoffice-desktopeditors
    ];

  system.stateVersion = "26.05";
}
