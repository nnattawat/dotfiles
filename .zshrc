
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export SHELL=/bin/zsh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# ZSH_THEME="robbyrussell"

# Always allow load .env
ZSH_DOTENV_PROMPT=false

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  macos
  tmux
  aws
  nvm
  npm
  pnpm
  yarn
  docker
  docker-compose
  kubectl
  python
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# alias vim="/usr/local/bin/vim"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

clear_local_branches() {
  git fetch -p;
  git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

refresh_local_branches() {
  clear_local_branches;
  git pull;
}

kill_sounds() {
  sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run nvm use when cd into a folder
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  # elif [ "$node_version" != "$(nvm version default)" ]; then
  #   echo "Reverting to nvm default version"
  #   nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

alias j='npx jest'
alias jwi='npx jest -i --watch'
alias ji='node --inspect-brk ./node_modules/.bin/jest'

alias nr='npm run'

# Docker setup
alias dc='docker-compose'
alias d='docker'
d_stop_containers () {
  CONTAINER_NAME_PREFIX=$1
  docker ps -q --filter name=$CONTAINER_NAME_PREFIX | xargs docker stop
}
d_remove_containers () {
  CONTAINER_NAME_PREFIX=$1
  docker ps -q --filter name=$CONTAINER_NAME_PREFIX | xargs docker stop && docker ps -aq --filter name=$CONTAINER_NAME_PREFIX | xargs docker remove
}

port_pid () {
  PORT=$1
  lsof -ti :$PORT
}

kill_port () {
  PORT=$1
  kill $(lsof -ti :$PORT)
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

grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,./log,./node_modules,/.vendor/.dist} -nriI "$KEYWORD" $FOLDER
}

if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# open github repo in browser
gh_open() {
  if [ -n "$1" ]; then
    open "https://github.com/nib-group/${1}"
    return 0
  fi

  repo=$(git remote -v | grep fetch | grep origin | sed -e's/.*github.com.//' | sed -e's/\.git.*//')

  open "https://github.com/${repo}"
}

# new pr on github repo in browser
gh_new_pr() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  repo=$(git remote -v | grep fetch | grep origin | sed -e's/.*github.com.//' | sed -e's/\.git.*//')

  if [ "$branch" = "develop" ]; then
    open "https://github.com/${repo}/compare/master...${branch}"
  else
    open "https://github.com/${repo}/pull/new/${branch}"
  fi
}

# Open Bitbucket repository in browser
bb_open() {
  local url="https://bitbucket.org/lendi-dev"

  if [ -n "$1" ]; then
    open "${url}/${1}"
    return 0
  fi

  repo=$(git remote -v | grep fetch | grep origin | sed -e's#.*/\([^.]*\)\.git.*#\1#')

  open "${url}/${repo}"
}

bb_new_pr() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  repo=$(git remote -v | grep fetch | grep origin | sed -e's#.*/\([^.]*\)\.git.*#\1#')

  if [ -n "$1" ]; then
    open "https://bitbucket.org/lendi-dev/${repo}/pull-requests/new?source=${branch}&dest=${1}"
    return 0
  fi

  open "https://bitbucket.org/lendi-dev/${repo}/pull-requests/new?source=${branch}"
}

# open buildkite pipeline of the repo in browser
bk_open() {

  if [ -n "$1" ]; then
    open "https://buildkite.com/lendi-pty-ltd/${1}"
    return 0
  fi

  repo=$(git remote -v | grep fetch | grep origin | sed -e's#.*/\([^.]*\)\.git.*#\1#')

  if [ "$repo" = "aurora" ]; then
    repo="aurora-pipeline"
  fi

  open "https://buildkite.com/lendi-pty-ltd/${repo}"
}

# open buildkite pipeline of the repo in browser
bk_open_branch() {

  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  repo=$(git remote -v | grep fetch | grep origin | sed -e's#.*/\([^.]*\)\.git.*#\1#')

  if [ "$repo" = "aurora" ]; then
    repo="aurora-pipeline"
  fi

  open "https://buildkite.com/lendi-pty-ltd/${repo}/builds?branch=${branch}"
}

eval "$(starship init zsh)"

# Tmux: show running command at top of pane (Zellij-style)
_tmux_set_pane_title() {
  [[ -z "$TMUX" ]] && return
  local cmd="$1"
  cmd="${cmd%%$'\n'*}"
  [[ ${#cmd} -gt 80 ]] && cmd="${cmd:0:77}..."
  command tmux set -p @pane_cmd_title "$cmd" 2>/dev/null
}
_tmux_init_pane_title() {
  [[ -z "$TMUX" ]] && return
  local current_title
  current_title="$(command tmux show -pv @pane_cmd_title 2>/dev/null)"
  [[ -n "$current_title" ]] && return
  command tmux set -p @pane_cmd_title "${SHELL:t}" 2>/dev/null
}
add-zsh-hook preexec _tmux_set_pane_title
add-zsh-hook precmd _tmux_init_pane_title

# Lendi specific

# brew for Mac chip is installed in different location
export PATH="/opt/homebrew/bin:$PATH"

