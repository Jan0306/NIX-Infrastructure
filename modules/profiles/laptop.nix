{ ... }:

{
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  users.users.jan.extraGroups = [
    "networkmanager"
  ];

  i18n.defaultLocale = "de_DE.UTF-8";
}
