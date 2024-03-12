# Directory

change_directory_list() {
  cd $1 || (pwd)
  ls -CF
}
alias cdl=change_directory_list

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

git_open_remote() {
  url=$(git config --get remote.origin.url)
  if [[ $url == *"@"* ]]; then
    open "https://${url#*@}"
  else
    open $url
  fi
}
alias gitor=git_open_remote

# Editor

if [ -f "$(command -v nvim)" ]; then
	alias vi='nvim'
	alias vim='nvim'
	export VISUAL=nvim
	export EDITOR=nvim
else
	export VISUAL=vim
	export EDITOR=vim
fi

alias c.='code .'
alias ci.='code-insiders .'

# Shell

alias cls='clear'
alias ipme='curl ifconfig.me/ip'
alias pn='pnpm'
alias cats='highlight -O ansi --force'

pnpm_check_package() {
  pnpm run typecheck
  pnpm run lint:check
  pnpm run test run
}
alias pncp='pnpm_check_package'

pnpm_install_all() {
  current_path=$(pwd)
  for dir in */; do
    if [ -f "$dir/pnpm-lock.yaml" ]; then
      echo "Installing: $dir";
      cd $dir
      pnpm install
      cd $current_path
      echo ""
    else
      echo "Not a pnpm project: $dir";
    fi
  done
}
alias pnia='pnpm_install_all'

# Preview file in quick look
ql () {
  qlmanage -p "$*" >& /dev/null &
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
alias dcr=restart_docker_compose

alias dcl='docker-compose logs -f'
alias dcp='docker-compose pull'
alias dcrm='docker-compose rm -f -s'
alias dcs='docker-compose stop'
alias dcup='docker-compose up -d'
