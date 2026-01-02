{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "eglavin";

  environment.systemPackages = with pkgs; [
    git
    htop
    neovim
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zsh.enable = true;

  users.users.eglavin = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.eglavin = import ./home.nix;

  system.stateVersion = "25.05";
}
