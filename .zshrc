# Override ls colors
if [ -f "$(command -v dircolors)" ]; then
  eval "$(dircolors -b $HOME/dotfiles/dircolors)" || eval "$(dircolors -b)"
fi

# Include nvim if installed to /opt/nvim
if [ -e /opt/nvim/nvim ]; then
  export PATH="$PATH:/opt/nvim/"
fi
# Include nvim if installed to /opt/nvim-linux64
if [ -e /opt/nvim-linux64/bin/nvim ]; then
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
    nvm
    sudo
    zsh-autosuggestions
  )

  source $ZSH/oh-my-zsh.sh
else
  # oh-my-zsh will include nvm alread so we need to include it if not using oh-my-zsh
  if [ -d $HOME/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  fi
fi

# Include my aliases
source $HOME/dotfiles/aliases.sh

# Duplicate panel in the current path in windows terminal
if [ -f "$(command -v wslpath)" ]; then
  keep_current_path() {
    printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
  }
  precmd_functions+=(keep_current_path)
fi

# Disable username in prompt
export DEFAULT_USER=$USER

# Include pnpm path
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$PATH"
fi

# Include local bin path
if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "/etc/profile.d/apps-bin-path.sh" ]; then
  source "/etc/profile.d/apps-bin-path.sh"
fi

# Include brew
if [ -x "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Include iterm2 shell integration
if [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Init zoxide if command found
if [ -f "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
fi

# Include golang from profile.d
if [ -f "/etc/profile.d/golang.sh" ]; then
  source "/etc/profile.d/golang.sh"
else
  # or include golang from /usr/local/go/bin
  if [ -d "/usr/local/go/bin" ]; then
    export GO111MODULE=on
    export PATH="$PATH:/usr/local/go/bin"
  fi
fi

# Disable homebrew auto updating
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_UPGRADE=1

# tabtab source for packages, uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
