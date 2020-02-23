{ pkgs ? import (builtins.fetchGit {
    # https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs

    # Descriptive name to make the store path easier to identify
    name = "nixpkgs-2020-02-22";

    url = https://github.com/NixOS/nixpkgs-channels/;

    # Commit hash for nixos-unstable as of 2020-01-06
    # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
    # or
    # `git ls-remote https://github.com/nixos/nixpkgs master`
    ref = "refs/heads/nixpkgs-unstable";

    rev = "f098b0dd2cdc008711938272b3d622cb55131706";
}) {}}:

with pkgs;

let
    haskellTools = haskell.packages.ghc865.ghcWithPackages (
        haskellPkgs: with haskellPkgs; [
            # tools
            cabal-install
        ]
    );

    # https://github.com/grpc/grpc/releases/tag/v1.2.5
    # https://github.com/awakesecurity/gRPC-haskell/blob/595cb6a3bfbc50348af44d4bbd981ba0c02e45dd/README.md#installation
    # https://github.com/awakesecurity/gRPC-haskell/issues/103
    supportedGrpc = grpc.overrideAttrs (oldAttrs: rec {
        version = "1.26.0";
        src = builtins.fetchGit {
            name = "grpc-${version}";
            url = https://github.com/grpc/grpc/;
            ref = "refs/tags/v${version}";
            rev = "de893acb6aef88484a427e64b96727e4926fdcfd";
        };
        patches = [];
    });

in

mkShell {
    buildInputs = [
        haskellTools
        zlib
        supportedGrpc
    ];
}