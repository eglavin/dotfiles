# Override ls colors
if [ -r $HOME/dotfiles/dircolors ]; then
  eval "$(dircolors -b $HOME/dotfiles/dircolors)" || eval "$(dircolors -b)"
fi

# Load node version manager
if [ -d $HOME/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# tabtab source for packages, uninstall by removing these lines
if [ -f $HOME/.config/tabtab/zsh/__tabtab.zsh ]; then
  source $HOME/.config/tabtab/zsh/__tabtab.zsh
fi

# Include nvim if installed to /opt/nvim
if [ -e /opt/nvim/nvim ]; then
  export PATH="$PATH:/opt/nvim/"
fi
# Include nvim if installed to
if [ -e /opt/nvim-linux64/bin/nvim ]; then
  export PATH="$PATH:/opt/nvim-linux64/bin/"
fi

# Laod oh-my-zsh
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
fi

# Include my aliases
source $HOME/dotfiles/aliases.sh

# Duplicate panel in the current path in windows terminal
keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)

# Disable username in prompt
export DEFAULT_USER=$USER

# Include pnpm path
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$PATH"
fi

# Include local bin path
if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi
