{ pkgs, ... }:

{
  users.users.jan = {
    isNormalUser = true;
    description = "Jan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGWN+/adzSEbOxFsIiGQOsfiPhFoiH+5gUj34KTZ2QpB jan@macbookpro"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIux+C3peLKR0RlApmkn8U2VFjvObdW18n6BuDiYObuY jan@pc"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDDE+/9dY9mFh5zRsNr1usqkcnmwP9YLqXivOM6RYq6D jan@work-laptop"
    ];
  };
}