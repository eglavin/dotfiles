{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "eglavin";

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.eglavin = { config, pkgs, ... }: {

    home.packages = with pkgs; [
      htop
      fzf
      ripgrep
    ];

    programs.git = {
      enable = true;
      settings.user.name = "Eanna Glavin";
      settings.user.email = "29385958+eglavin@users.noreply.github.com";
    };

    programs.zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
        plugins = [ "git" "z" "zsh-autosuggestions" "python" "virtualenv" ];
      };
    };

    home.stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}
