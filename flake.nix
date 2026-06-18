{
  description = "NIX Infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      macbookair = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/common.nix
          ./modules/users.nix

          ./hosts/macbookair/configuration.nix
          ./hosts/macbookair/hardware-configuration.nix

          ./modules/hosts/macbook.nix
        ];
      };

      testvm1 = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/common.nix
          ./modules/users.nix

          ./hosts/testvm1/configuration.nix
          ./hosts/testvm1/hardware-configuration.nix
        ];
      };
    };
  };
}