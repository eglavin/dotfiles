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
    bat
    btop
    bun
    delta
    eza
    fnm
    fzf
    gdu
    gping
    jq
    lazygit
    nmap
    peazip
    ripgrep
    scc
    tree
    unzip
    yq
    zip
    zoxide
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Eanna Glavin";
        email = "29385958+eglavin@users.noreply.github.com";
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        eol = "native";
        safecrlf = "warn";
        autocrlf = "input";
        longpaths = true;
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
        pager = "delta";
      };
      apply = {
        whitespace = "fix";
      };
      push = {
        autoSetupRemote = true;
        default = "current";
      };
      merge = {
        autoStash = true;
        log = true;
        conflictStyle = "diff3";
      };
      rebase = {
        autoStash = true;
      };
      pull = {
        rebase = true;
      };
      diff = {
        renames = "copies";
        colorMoved = "default";
      };
      pager = {
        branch = "false";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        sideBySide = true;
        lineNumbers = true;
        navigate = true;
      };
    };
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

    initContent = ''
      if [ -f ~/dotfiles/aliases.sh ]; then
        source ~/dotfiles/aliases.sh
      fi

      # fnm
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "z" "python" "virtualenv" ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
