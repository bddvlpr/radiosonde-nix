{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    radiosonde-auto-rx = {
      url = "github:projecthorus/radiosonde_auto_rx?ref=testing";
      flake = false;
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = {pkgs, ...} @ args: rec {
        formatter = pkgs.alejandra;

        packages = import ./pkgs ({inherit inputs;} // args);
        checks = packages;
      };
    };
}
