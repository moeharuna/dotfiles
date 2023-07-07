{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, fenix, nixpkgs }: {
    packages.x86_64-linux.default = fenix.packages.x86_64-linux.default.toolchain;
    nixosConfigurations.kaguya = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # targets.wasm32-unknown-unknown.latest.rust-std
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ fenix.overlays.default ];
          environment.systemPackages = with pkgs; [
            (fenix.packages.${system}.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
              "miri"
            ])
            rust-analyzer-nightly
          ];
          })];
    };
  };
}
