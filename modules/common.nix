{ config, pkgs, ... }:

{
  # Enable NetworkManager for network configuration
  networking.networkmanager.enable = true;

  #  Set the default gateway and DNS nameservers
  networking = {
    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" "8.8.8.8" ];
  };
  
  # Set system time zone
  time.timeZone = "Europe/Berlin";

  # Set default locale
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Installing system packages
  environment.systemPackages = with pkgs; [
   git
   hyfetch
  ];

  # Enable OpenSSH server with secure settings
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";
}