{
  description = "A Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { system, pkgs, ... }:
        let
          configuration = nixvim.lib.evalNixvim {
            inherit system;

            # Import your Nixvim modules
            modules = [ ./config ];

            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };
        in
        {
          # Run `nix flake check .` to verify that your config is not broken
          checks.default = configuration.config.build.test;

          # Lets you run `nix run .` to start nixvim
          packages.default = configuration.config.build.package;

          # Dev shell for Nix development
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nil # Nix LSP server
              nixfmt # Nix formatter
            ];
          };
        };
    };
}
