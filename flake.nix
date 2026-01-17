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
      mkHome = username:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

            modules = [
              inputs.plasma-manager.homeModules.plasma-manager
              ./home.nix
              {
                home.username = username;
                home.homeDirectory = "/home/${username}";
              }
            ];
          };
      system = "x86_64-linux";
    in
    {
    homeConfigurations = {
        meowxiik = mkHome "meowxiik";
        rhajek   = mkHome "rhajek";
      };
    };
}
