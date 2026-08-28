{
  description = "NIX Infrastructure";

  inputs = {
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      macbookair = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
	  ./modules/base.nix
	  ./modules/profiles/laptop.nix
	  ./modules/profiles/desktop-plasma.nix
          ./modules/users.nix
          ./hosts/macbookair/configuration.nix

          nixos-hardware.nixosModules.apple-t2
        ];
      };

      t480 = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/base.nix
	  ./modules/profiles/laptop.nix
          ./modules/profiles/desktop-plasma.nix
	  ./modules/users.nix
          ./hosts/t480/configuration.nix

	  nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };

      testvm1 = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./modules/base.nix
	  ./modules/profiles/server.nix
	  ./modules/users.nix

          ./hosts/testvm1/configuration.nix
        ];
      };
    };
  };
}
