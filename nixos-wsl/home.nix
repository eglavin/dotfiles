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
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "zsh-autosuggestions" "python" "virtualenv" ];
    };
  };
}
