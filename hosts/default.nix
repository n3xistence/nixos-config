{ lib, inputs, system, home-manager, user, ... }:

{

  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.nex = {
          imports  = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
        };
      }
    ];
  };
}
