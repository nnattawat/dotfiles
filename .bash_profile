# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White
# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White
NC="\e[0m"              # Color Reset

export EDITOR=vim

source ~/git-completion.bash

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# To use the lastest installed version of git. Not the one comewith xcode (/usr/local/bin)
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH=$PATH:/usr/local/mysql/bin
export HISTCONTROL=ignoredups:erasedups

alias brspec='bin/rspec'
alias brake='bin/rake'
alias brails='bin/rails'
alias be='bundle exec'
alias ssh-sys-bbn='ssh -p222 -A bookingbutton@sys.thebookingbutton.com'
alias ssh-prod-db='ssh bastion.uswest2.siteminder.com'
alias ssh-uat='ssh bookingbutton@bbuat.siteminder.com'
alias ssh-tpi='ssh bookingbutton@bbtpi.siteminder.com'
alias rails-pry='pry -r ./config/environment.rb'
alias mysql-start='sudo /usr/local/mysql/support-files/mysql.server start'
alias postgres-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias postgres-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias postgre-reset='rm /usr/local/var/postgres/postmaster.pid'

FullStar="★ "
Wine="🍷 "

clear_local_branches() {
remote_branches=`git branch -r --no-color --list | grep -v HEAD | sed -e 's/  origin\///g'`
local_branches=`git branch --no-color | sed -e 's/[ *]//g'`

for branch in $local_branches; do
  if [[ ! $remote_branches =~ $branch ]]; then
    while true; do
      read -p "Do you want to delete this branch: $branch ? (y/n [n]) " yn
      case $yn in
        [Yy]* ) git branch -D $branch; break;;
        * ) break;;
      esac
    done
  fi
done
}

reload_db() {
bundle exec rake db:drop>/dev/null;
bundle exec rake db:create>/dev/null;
printf "$Wine DB has been recreated.\n";
}

reload_data_tbb() {
environment=($@)
possible_env='test dev prod development production'
if [[ ! $environment || ! $possible_env =~  $environment ]]; then
  while true; do
    read -p "load schema for which env? (test/dev/prod/cancel/c) " answer
    case $answer in
      test | dev | prod ) environment=$answer; break;;
      c | cancel ) return;;
      * ) echo "I don't understand...";;
    esac
  done
fi
case $environment in
  [dev]*) environment=development;;
  [prod]*) environment=production;;
esac
case $environment in
  test )  printf "$Green$FullStar$NC rake db:schema:load\n";
    bundle exec rake db:schema:load RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC Schema loaded.\n";
    printf "\n$Wine $environment environement ready! $Wine\n";
    ;;
  development | production )
    printf "$Green$FullStar$NC rake db:schema:load\n";
    bundle exec rake db:schema:load RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC Schema loaded.\n";
    printf "$Green$FullStar$NC rake db:seed RAILS_ENV=$environment\n";
    bundle exec rake db:seed RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC Seed loaded.\n";
    if [ -f script/utils/create_property.rb ];then
      printf "$Green$FullStar$NC rails runner script/utils/create_property.rb\n";
      bundle exec rails runner script/utils/create_property.rb RAILS_ENV=$environment 1>/dev/null
      printf "$Green$FullStar$NC Property loaded.\n";
    fi
    printf "\n$Wine $environment environement ready! $Wine\n";
    ;;
esac
}

# function goto (working directory)
# INFO: You should change 'Work' to your working directory
#
goto() {
cd $HOME/Workspace/$1
}
# Completion for goto
#
_complete_goto_folders () {
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  comp_goto_folders=`/bin/ls $HOME/Workspace/`
  COMPREPLY=( $(compgen -W "$comp_goto_folders" -- $cur))
  return 0
}
complete -F _complete_goto_folders goto

search() {
KEYWORD=$1
FOLDER=$2
if [ -z "$KEYWORD" ] && [ -z "$FOLDER" ]
then
  echo "search folder was not given"
  return 1
fi
if [ -z "$FOLDER" ]
then
  FOLDER="."
fi
grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -nrI $KEYWORD $FOLDER
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias ctags='/usr/local/bin/ctags'

# Docker setup
eval "$(docker-machine env tbb)"
alias dm='docker-machine'
alias dc='docker-compose'
alias d='docker'

remove_dangling_containers () {
  docker images -q -f='dangling=true' | xargs docker rmi
}

sync_dot_files () {
  ruby /Users/nattawatnonsung/Workspace/playground/rsync/rsync.rb
}