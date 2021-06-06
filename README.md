# Dotfiles 👽
---
Reproducible set of dotfiles and macos configs for zsh terminal on OS X 11+.

| OneDark | OneLight |
| - | - |
| ![dark](dark.png) | ![light](light.png) |

## Install

```shell
$ # Install Nix (single-user mode)
$ sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
$ echo ". $HOME/.nix-profile/etc/profile.d/nix.sh" >> .zshrc
$ # Pull the dotfiles
$ git clone https://github.com/a-voronov/dotfiles
$ # Apply nix configs
$ cd dotfiles
$ nix-env -f default.nix -i
$ echo 'if [ -x "$(command -v zshrc)" ]; then $(zshrc); fi' >> .zshrc
$ # Apply macOS configs (will quit all affected applications, including Terminal)
$ sh .macos
```

## Credits

* Nix: This is my very first and initial nix setup copied from [Homies](https://github.com/nmattia/homies/tree/7a6c82aa7c7b41e915b79ff0de9f8e4c185c1622) following [Nix: A Reproducible Setup for Linux and macOS](https://www.nmattia.com/posts/2018-03-21-nix-reproducible-setup-linux-macos.html)

* macOS: `.macos` config is based on https://mths.be/macos


## Uninstall

In case nix needs to be uninstalled or reinstalled for some reason:

* `rm -rf /nix`
* `rm -rf ~/.nix-profile`
* `rm -rf ~/.nix-defexpr`
* `rm -rf ~/.cache/nix`
* `rm ~/.nix-channels`
* remove `Nix Store` Volume in `Disk Utility`
* remove `nix` from `/etc/synthetic.conf`
* might need to restart mac
