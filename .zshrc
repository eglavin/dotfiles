# Disable username in prompt
export DEFAULT_USER=$USER

# oh-my-zsh
if [ -d $HOME/.oh-my-zsh ]; then
  export ZSH=$HOME/.oh-my-zsh

  HIST_STAMPS="yyyy-mm-dd"
  ZSH_THEME="agnoster"
  plugins=(git zsh-autosuggestions)

  source $ZSH/oh-my-zsh.sh
else
  mkdir $HOME/.oh-my-zsh

  git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

  echo ""
  echo "Restart zsh to load oh-my-zsh"
fi

############################################
# WSL Specific Options

# Duplicate panel in the current path in windows terminal
if [ -f "$(command -v wslpath)" ]; then
  keep_current_path() {
    printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
  }
  precmd_functions+=(keep_current_path)
fi

############################################
# OSX Specific Options

# brew
if [ -x /opt/homebrew/bin/brew ]; then
  # Disable homebrew auto updating
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_UPGRADE=1

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# iterm2
[ -e $HOME/.iterm2_shell_integration.zsh ] && source $HOME/.iterm2_shell_integration.zsh

############################################
# Linux Specific Options

# linuxbrew
if [ -d /home/linuxbrew/.linuxbrew ]; then
  # Disable homebrew auto updating
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_UPGRADE=1

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# snap
[ -f /etc/profile.d/apps-bin-path.sh ] && source /etc/profile.d/apps-bin-path.sh

############################################

[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"
[ -d $HOME/bin ] && export PATH="$HOME/bin:$PATH"

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

source $HOME/dotfiles/aliases.sh

############################################

# dircolors
if [ -f "$(command -v dircolors)" ]; then
  eval "$(dircolors -b $HOME/dotfiles/dircolors)" || eval "$(dircolors -b)"
fi

# fzf
[ -f "$(command -v fzf)" ] && source <(fzf --zsh)

# zoxide
[ -f "$(command -v zoxide)" ] && eval "$(zoxide init zsh)"

# fnm
if [ -d $HOME/.local/share/fnm ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
fi
if [ -f "$(command -v fnm)" ]; then
  eval "$(fnm env)"
  eval "$(fnm completions --shell zsh)"
fi

# pnpm
[ -f $HOME/.pnpm-tab-completion.sh ] && source $HOME/.pnpm-tab-completion.sh

# bun
if [ -f $HOME/.bun/_bun ]; then
  source $HOME/.bun/_bun
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

############################################
