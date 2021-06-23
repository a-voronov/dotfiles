# Taken from initial version of Homies: github.com/nmattia/homies 
# More here: www.nmattia.com/posts/2018-03-21-nix-reproducible-setup-linux-macos.html

let
  # Using Niv github.com/nmattia/niv for pinned channels, more here:
  # nixos.org/guides/towards-reproducibility-pinning-nixpkgs.html
  sources = import ./nix/sources.nix;
  # Waiting for https://github.com/NixOS/nixpkgs/issues/95903
  # Also check ~/.config/nix/nix.conf
  armPkgs = import sources.nixpkgs { localSystem = "aarch64-darwin"; };
  x86Pkgs = import sources.nixpkgs { localSystem = "x86_64-darwin"; };

  # The list of packages to be installed
  homeARMPkgs = with armPkgs;
    [
      # Customized packages
      homeZshrc
      homeGit

      curl
      jq
      tree
      cmake
      gradle
      cocoapods
      docker
      openvpn
      # Consider looking at https://github.com/nix-community/nix-direnv
      # to make direnv snappier thanks to env cache
      direnv
      # will be missing after clean install, if not included here
      nix
      cacert
      # Package to handle existing Gemfile-based projects
      # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/ruby.section.md#using-an-existing-gemfile
      bundix
    ];

  # Packages that don't support Apple Silicone yet
  homeX86Pkgs = with x86Pkgs;
    [
      niv
      # GUI applications aren't automatically linked to ~/Applications directory
      # More here: https://github.com/NixOS/nix/issues/956
      # Hence no need to manage Slack or Discord with Nix
      emacs
    ];

  pkgs = armPkgs;
  homePkgs = homeARMPkgs ++ homeX86Pkgs;

  ## Some cunstomizations

  # A custom '.zshrc' (see zshrc/default.nix for details)
  homeZshrc = import ./zshrc (with pkgs;
    { inherit
        writeScriptBin
        ;
    });

  # Git with config baked in
  homeGit = import ./git (with pkgs;
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
