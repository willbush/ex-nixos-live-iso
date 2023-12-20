{ modulesPath, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  isoImage.edition = "plasma5";

  services = {
    xserver = {
      desktopManager.plasma5.enable = true;

      # Automatically login as nixos.
      displayManager = {
        sddm.enable = true;
        autoLogin = {
          enable = true;
          user = "nixos";
        };
      };
    };
    # Enables copy / paste when running in a KVM with spice.
    spice-vdagentd.enable = true;
  };

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
      starship.enable = true;
      alacritty.enable = true;

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
      };
    };
  };

  system.activationScripts.installerDesktop =
    let

      # Comes from documentation.nix when xserver and nixos.enable are true.
      manualDesktopFile =
        "/run/current-system/sw/share/applications/nixos-manual.desktop";

      homeDir = "/home/nixos/";
      desktopDir = homeDir + "Desktop/";

    in
    ''
      mkdir -p ${desktopDir}
      chown nixos ${homeDir} ${desktopDir}

      ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
      ln -sfT ${pkgs.alacritty}/share/applications/Alacritty.desktop ${desktopDir + "Alacritty.desktop"}
      ln -sfT ${pkgs.calamares-nixos}/share/applications/io.calamares.calamares.desktop ${desktopDir + "io.calamares.calamares.desktop"}
      ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    '';
}
