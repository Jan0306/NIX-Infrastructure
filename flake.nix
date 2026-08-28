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
	  ./modules/base.nix
	  ./modules/profiles/desktop-plasma.nix
          ./modules/users.nix

          ./hosts/macbookair/configuration.nix

          nixos-hardware.nixosModules.apple-t2
        ];
      };

      t480 = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/common.nix
          ./modules/users.nix
	  ./modules/base.nix 
          ./modules/profiles/desktop-plasma.nix

          ./hosts/t480/configuration.nix

	  nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };

      testvm1 = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/common.nix
          ./modules/users.nix
	  ./modules/base.nix

          ./hosts/testvm1/configuration.nix
        ];
      };
    };
  };
}
