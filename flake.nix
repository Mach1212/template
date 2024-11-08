{
  description = "Dioxus nightly devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              pkg-config
              tailwindcss
              openssl
              perl
              mold
              lld
              clang
              (
                rust-bin.selectLatestNightlyWith (toolchain:
                  toolchain.default.override {
                    extensions = [
                      "rust-src"
                      "rust-std"
                      "rustc-codegen-cranelift-preview"
                      "rust-analyzer-preview"
                      "rustfmt-preview"
                    ];
                    targets = ["wasm32-unknown-unknown"];
                  })
              )
            ];
          };
      }
    );
}
