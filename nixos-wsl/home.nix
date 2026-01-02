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
    dotDir = "${config.xdg.configHome}/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "${config.xdg.configHome}/zsh/zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };

    initExtra = ''
      if [ -f ~/dotfiles/aliases.sh ]; then
        source ~/dotfiles/aliases.sh
      fi
    '';

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "python" "virtualenv" ];
    };
  };
}
