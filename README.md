# ex-nixos-live-iso

An example of how to create a custom NixOS live CD/ISO with nix
[flakes](https://nixos.wiki/wiki/Flakes).

If you don't have nix, I recommend installing it with the following because it
has flakes enabled by default: https://zero-to-nix.com/start/install

Build the ISO with:

```sh
$ nix build .#iso
```

The resulting ISO will be in `./result/iso/`
