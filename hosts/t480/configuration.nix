{ config, pkgs, ... }:

let
  hosts = import ../../lib/hosts.nix;
  host = hosts.clients.t480;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = host.hostname;

  services.libinput.touchpad.naturalScrolling = true;

  environment.systemPackages = with pkgs; [
    brave
    alacritty
  ];

  system.stateVersion = "26.05";

}
