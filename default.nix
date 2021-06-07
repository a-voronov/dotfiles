# Taken from initial version of Homies: github.com/nmattia/homies 
# More here: www.nmattia.com/posts/2018-03-21-nix-reproducible-setup-linux-macos.html

let
  # Once it's clear how all of this works, move to using Niv github.com/nmattia/niv
  # Also mentioned on official website nixos.org/guides/towards-reproducibility-pinning-nixpkgs.html
  pkgs = import <nixpkgs> {};

  # The list of packages to be installed
  homePkgs = with pkgs;
    [
      # Customized packages
      zshrc
      git

      pkgs.tree
      pkgs.cocoapods
      # will be missing after clean install, if not included here
      pkgs.nix
      pkgs.cacert
      # Package to handle existing Gemfile-based projects
      # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/ruby.section.md#using-an-existing-gemfile
      pkgs.bundix
      # GUI applications aren't automatically linked to ~/Applications directory
      # More here: https://github.com/NixOS/nix/issues/956
      # Hence no need to manage Slack or Discord with Nix
      pkgs.emacs
    ];

  ## Some cunstomizations

  # A custom '.zshrc' (see zshrc/default.nix for details)
  zshrc = import ./zshrc (with pkgs;
    { inherit
        writeScriptBin
        ;
    });

  # Git with config baked in
  git = import ./git (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        writeTextFile
        ;
      git = pkgs.git;
    });

in
  if pkgs.lib.inNixShell
  then pkgs.mkShell
    { buildInputs = homePkgs;
      shellHook = ''
        $(zshrc)
        '';
    }
  else homePkgs
