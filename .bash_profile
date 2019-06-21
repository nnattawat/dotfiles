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

# Maven version used by QBR portal
export M2_HOME=/usr/local/apache-maven-3.2.3

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source ~/tmux.completion.bash

export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'

# Erica pass
export PASSWORD_STORE_DIR=/Users/nnattawat/.ericapasswordstore/erica-password-store

eval "$(hub alias -s)"


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# To use the lastest installed version of git. Not the one comewith xcode (/usr/local/bin)
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:$HOME/bin
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
alias redis-start='redis-server /usr/local/etc/redis.conf'
alias postgres-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias postgres-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias postgre-reset='rm /usr/local/var/postgres/postmaster.pid'

FullStar="★ "
Wine="🍷 "

clear_local_branches() {
git remote update --prune;

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

reload_rails_data() {
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
  test )
    printf "$Green$FullStar$NC rake db:drop RAILS_ENV=$environment\n";
    bin/rake db:drop RAILS_ENV=$environment>/dev/null;
    printf "$Green$FullStar$NC rake db:create RAILS_ENV=$environment\n";
    bin/rake db:create RAILS_ENV=$environment>/dev/null;
    printf "$Green$FullStar$NC rake db:schema:load RAILS_ENV=$environment\n";
    bin/rake db:schema:load RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC Schema loaded.\n";
    printf "\n$Wine $environment environment ready! $Wine\n";
    ;;
  development | production )
    printf "$Green$FullStar$NC rake db:drop RAILS_ENV=$environment\n";
    bin/rake db:drop RAILS_ENV=$environment>/dev/null;
    printf "$Green$FullStar$NC rake db:create RAILS_ENV=$environment\n";
    bin/rake db:create RAILS_ENV=$environment>/dev/null;
    printf "$Green$FullStar$NC rake db:schema:load RAILS_ENV=$environment\n";
    bin/rake db:schema:load RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC rake db:seed RAILS_ENV=$environment\n";
    bin/rake db:seed RAILS_ENV=$environment 1>/dev/null;
    printf "$Green$FullStar$NC Seed loaded.\n";
    printf "\n$Wine $environment environment ready! $Wine\n";
    ;;
esac
}

reload_all_rails_db() {
  reload_rails_data dev &
  pid1=$!
  reload_rails_data test &
  pid2=$!

  wait $pid1 || "reloading dev db error with status $?"
  wait $pid2 || "reloading dev db error with status $?"
}

search() {
KEYWORD=$1
FOLDER=$2
if [ -z "$KEYWORD"   ]
then
  echo "please give keyword"
  exit 1
fi
if [ -z "$FOLDER"   ]
then
  FOLDER="."
fi

grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,./log,./node_modules,/.vendor} -nriI "$KEYWORD" $FOLDER
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias ctags='/usr/local/bin/ctags'

# Docker setup
# eval "$(docker-machine env tbb)"
alias dm='docker-machine'
alias dc='docker-compose'
alias d='docker'
d_stop_containers () {
  docker ps -aq | xargs docker rm -f
}

d_remove_images () {
  docker images -aq | xargs docker rmi -f
}

d_remove_dangling_containers () {
  docker images -q -f='dangling=true' | xargs docker rmi -f
}

sync_dot_files () {
  ruby /Users/nattawatnonsung/Workspace/playground/rsync/rsync.rb
}

vundle () {
  vim +PluginInstall +qall
}

eval "$(direnv hook bash)"

port_pid () {
  KILL_PORT=$1
  lsof -ti :$KILL_PORT
}

kill_port () {
  KILL_PORT=$1
  kill $(lsof -ti :$KILL_PORT)
}

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash  ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash  ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion"  ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
