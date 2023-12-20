{
  description = "Custom NixOS live ISO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system}.iso =
        self.nixosConfigurations.iso.config.system.build.isoImage;

      nixosConfigurations = {
        iso = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            (./iso.nix)

            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
          ];
        };
      };
    };
}
