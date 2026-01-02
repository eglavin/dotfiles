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
    curl
    file
    git
    htop
    neovim
    wget
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
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

  # https://github.com/LGUG2Z/nixos-wsl-starter/blob/780c583f22046e238306d24c99cf09cd02d8f1aa/wsl.nix#L70
  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = ["default.target"];
      pathConfig.PathChanged = "%h/.vscode-server/bin";
    };
    services.vscode-remote-workaround.script = ''
      for i in ~/.vscode-server/bin/*; do
        if [ -e $i/node ]; then
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs_18}/bin/node $i/node
        fi
      done
    '';
  };
}
