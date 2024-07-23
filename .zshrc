# Override ls colors
if [ -f "$(command -v dircolors)" ]; then
  eval "$(dircolors -b $HOME/dotfiles/dircolors)" || eval "$(dircolors -b)"
fi

# Disable username in prompt
export DEFAULT_USER=$USER

if [ -e /opt/nvim/nvim ]; then
  # Include nvim if installed to /opt/nvim
  export PATH="$PATH:/opt/nvim/"
elif [ -e /opt/nvim-linux64/bin/nvim ]; then
  # Include nvim if installed to /opt/nvim-linux64
  export PATH="$PATH:/opt/nvim-linux64/bin/"
fi

# Include oh-my-zsh
if [ -d $HOME/.oh-my-zsh ]; then
  export ZSH=$HOME/.oh-my-zsh

  # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  ZSH_THEME="agnoster"

  # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" see 'man strftime' for details
  HIST_STAMPS="yyyy-mm-dd"

  plugins=(
    cp
    git
    npm
    sudo
    zsh-autosuggestions
  )

  source $ZSH/oh-my-zsh.sh
fi

############################################

# My aliases
source $HOME/dotfiles/aliases.sh

# User's .profile if exists
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# profile.d scripts, snap, golang etc.
if [ -f "/etc/profile.d/apps-bin-path.sh" ]; then
  source "/etc/profile.d/apps-bin-path.sh"
fi
if [ -f "/etc/profile.d/golang.sh" ]; then
  source "/etc/profile.d/golang.sh"
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

# Disable homebrew auto updating
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

# Include brew
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Include iterm2 shell integration
if [ -e "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

############################################

# fzf
if [ -f "$HOME/.fzf.zsh" ]; then
  source $HOME/.fzf.zsh
fi

# Zoxide
if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
fi

# fnm
if [ -d "$HOME/.local/share/fnm" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
fi
if [ -f "$(command -v fnm)" ]; then
  eval "$(fnm env)"
  eval "$(fnm completions --shell zsh)"
fi

# pnpm
if [ -f "$HOME/.pnpm-tab-completion.sh" ]; then
  source "$HOME/.pnpm-tab-completion.sh"
fi

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

############################################
