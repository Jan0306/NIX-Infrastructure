{ config, pkgs, ... }:

let
  hosts = import ../../lib/hosts.nix;
  host = hosts.clients.t480;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/users.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = host.hostname;

  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    brave
    alacritty
  ];

  system.stateVersion = "26.05";

}
