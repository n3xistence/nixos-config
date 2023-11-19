{
  description = "Default NixOS Setup with Home-Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      user = "nex";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      lib = nixpkgs.lib;
    in 
    {
      nixosConfigurations = {
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs user system home-manager;
        }
    };
}
