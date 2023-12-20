{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
  ];

  # Enables copy / paste when running in a KVM with spice.
  services.spice-vdagentd.enable = true;

  users.users.nixos.shell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    mkpasswd
    neovim
    ripgrep
    tree
    wget
  ];

  home-manager.users.nixos = {
    home.stateVersion = "21.11";

    programs = {
      alacritty.enable = true;
      fzf.enable = true; # enables zsh integration by default
      starship.enable = true;

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
      };
    };
  };
}
