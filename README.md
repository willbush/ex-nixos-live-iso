# ex-nixos-live-iso

An example of how to create a custom NixOS live CD/ISO with nix
[flakes](https://nixos.wiki/wiki/Flakes).

If you don't have Nix installed, I recommend using the Determinate Systems Nix
installer (reasons given on the website):

https://zero-to-nix.com/concepts/nix-installer

Build the ISO with:

```sh
$ nix build .#iso
```

The resulting ISO will be in `./result/iso/`
