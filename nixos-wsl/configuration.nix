{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "eglavin";

  # Setup shell
  programs.zsh.enable = true;
  users.users.eglavin = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = [
    pkgs.git
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.eglavin = { pkgs, ... }: {
    # This must match your system stateVersion
    home.stateVersion = "25.05";

    # 3. Move your user-specific packages here
    home.packages = with pkgs; [
      htop
      fzf
      ripgrep
    ];

    # 4. Example: Manage Git via Home Manager
    programs.git = {
      enable = true;
      userName = "Eanna Glavin";
      userEmail = "29385958+eglavin@users.noreply.github.com";
    };
  };

  system.stateVersion = "25.05";
}
