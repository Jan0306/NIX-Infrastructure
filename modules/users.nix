{ pkgs, ... }:

{
 users.users.jan = {
  isNormalUser = true;
  description = "Jan";
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [];
  openssh.authorizedKeys.keys = [
   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWN+/adzSEbOxFsIiGQOsfiPhFoiH+5gUj34KTZ2QpB janrobbers@MacBook-Pro-von-Jan.fritz.box"
  ];
 };
}