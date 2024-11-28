# Don't do anything if running interactively.
case $- in
    *i*) ;;
      *) return;;
esac

# Autocorrect capitalisation
bind 'set completion-ignore-case on'

# Bash history options
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48 (ISO/IEC-6429). (Lack of such support
		# is extremely rare, and such a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\w\$ '
fi
unset color_prompt force_color_prompt

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable this, if it's
# already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

############################################

# dircolors
if [ -f "$(command -v dircolors)" ]; then
	eval "$(dircolors -b $HOME/dotfiles/.config/dircolors/config)" || eval "$(dircolors -b)"

	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

source $HOME/dotfiles/aliases.sh

############################################
# WSL Specific Options

# Duplicate panel in the current path in windows termianl
if [ -f "$(command -v wslpath)" ]; then
	PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
fi

############################################

# fzf
[ -f "$(command -v fzf)" ] && eval "$(fzf --bash)"

# zoxide
[ -f "$(command -v zoxide)" ] && eval "$(zoxide init bash)"

# fnm
if [ -d $HOME/.local/share/fnm ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
fi
if [ -f "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd --shell bash)"
  eval "$(fnm completions --shell bash)"
fi

# cargo
if [ -d $HOME/.cargo ]; then
  . "$HOME/.cargo/env"
fi

############################################
