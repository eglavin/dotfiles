# Directory

change_directory_list() {
  cd $1 || (pwd)
  ls -CF
}
alias cdl=change_directory_list

if [ -f "$(command -v eza)" ]; then
  alias ls="eza"
  alias ll="eza -l"
  alias l="eza -la"
  alias la="eza -la"
  alias lsa="eza -la"
  alias lt="eza -la --sort=modified --reverse"
else
  alias ll="ls -lh"
  alias l="ls -lAh"
  alias la="ls -lAh"
  alias lsa="ls -lAh"
fi

# Git

git_who_am_i() {
  echo "Name: $(git config --global user.name)"
  echo "Email: $(git config --global user.email)"
}
alias gitwhoami=git_who_am_i

git_push_branch() {
  branch=$(git branch --show)
  git push -u origin $branch
}
alias gitpb=git_push_branch

# Azure Repos by default has the URL in the form of `https://<organisation>@<url>`, so we want
# to ignore the organisation part when opening the url if the repo has an @ symbol.
get_repo_url() {
  url="$(git config --get remote.origin.url)"
  if [[ $url == *"@"* ]]; then
    echo "https://${url#*@}"
  else
    echo $url
  fi
}
# If wslview is available, use it to open the URL in the default browser in Windows otherwise, try
# using the open command.
# https://github.com/wslutilities/wslu
git_open_remote() {
  if [ -f "$(command -v wslview)" ]; then
    wslview $(get_repo_url)
  else
    open $(get_repo_url)
  fi
}
alias gitor=git_open_remote

# Editor

if [ -f "$(command -v nvim)" ]; then
  alias vi="nvim"
  alias vim="nvim"
  export VISUAL=nvim
  export EDITOR=nvim
else
  export VISUAL=vim
  export EDITOR=vim
fi

function open_code() {
  if [ -z "$*" ]; then
    code .
  else
    code "$*"
  fi
}
alias c.=open_code

function open_code_insiders() {
  if [ -z "$*" ]; then
    code-insiders .
  else
    code-insiders "$*"
  fi
}
alias ci.=open_code_insiders

# Shell

alias cls=clear
alias ipme="curl ifconfig.me/ip"
alias pn=pnpm
alias cats="highlight -O ansi --force"
if [ -f "$(command -v batcat)" ]; then
  alias bat="batcat"
fi

pnpm_check_package() {
  pnpm run typecheck
  pnpm run lint:check
  pnpm run test run
}
alias pncp=pnpm_check_package

normalise_line_endings() {
  if [ -f "$1" ]; then
    sed -i.bak "s/\r$//" "$1"
  else
    echo "File not found"
  fi
}

e() {
  if [[ $# -eq 0 ]]; then
    cd "$HOME"
  elif [[ $# -eq 1 && ( -d "$1" || "$1" == "-" ) ]]; then
    cd "$1"
    ls -a
  elif [[ -f "$1" || ! -e "$1" || $# -gt 1 ]]; then
    $EDITOR "$@"
  else
    echo "e: case not accounted for"
  fi
}

# Preview file in quick look
ql() {
  qlmanage -p "$*" >&/dev/null &
}

# Docker

connect_to_docker_container() {
  docker exec -it $1 /bin/bash
}
alias dce=connect_to_docker_container

restart_docker_compose() {
  docker-compose stop
  docker-compose up -d
}
alias dcrestart=restart_docker_compose

alias dclogs="docker-compose logs -f"
alias dcpull="docker-compose pull"
alias dcrm="docker-compose rm -f -s"
alias dcstop="docker-compose stop"
alias dcup="docker-compose up -d"
