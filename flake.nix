{
  description = "Plasma Manager Example with standalone home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager/d4fae34";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }:
    let
      user-vars = import ./user-vars.nix;
      username = user-vars.username;
      system = "x86_64-linux";
    in
    {
      homeConfigurations.meowxiik = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

        modules = [
          inputs.plasma-manager.homeModules.plasma-manager

          # Specify the path to your home configuration here:
          ./home.nix

          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }
        ];
      };
    };
}
