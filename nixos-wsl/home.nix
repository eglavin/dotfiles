{
  config,
  pkgs,
  ...
}:
{
  home.username = "eglavin";
  home.homeDirectory = "/home/eglavin";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
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
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "python" "virtualenv" ];
    };
  };
}
