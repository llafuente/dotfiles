# load common staff, when .bashrc it's not used
source ~/.bash_common;

#normal promnt
PS1="[\[\033[01;31m\]${LOGNAME}\[\033[00m\]@\[\033[01;32m\]${INSTANCE_NAME}\[\033[00m\] \[\033[01;36m\]\w\[\033[00m\]]"

# bash -x promnt
PS4='+ \011\e[1;30m\t\011\e[1;34m${BASH_SOURCE}\e[0m:\e[1;36m${LINENO}\e[0m \011 ${FUNCNAME[0]:+\e[0;35m${FUNCNAME[0]}\e[1;30m()\e[0m:\011\011 }'


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# history size & no duplicates & dates
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '

# Save and reload the history after each command finishes
# this share history between tabs, after using it, it dangerous...
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;
shopt -s globstar

# No ttyctl, so we need to save and then restore terminal settings
# maybe: bind -r '\C-s'
stty -ixon

mkd() {
  mkdir -p "$@" && cd "$_";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
  else # pipe
    python -mjson.tool | pygmentize -l javascript;
  fi;
}

# compress/extract

x() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "Unable to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

cpperms() {
  chown --reference $1 $2;
  chmod --reference $1 $2;
  getfacl $1 | setfacl -f - $2;
}

# replace current term with a terminator with a know layout
term() {
  case "$1" in
    "gen3") CWD=$2; (nohup terminator -m -l gen3 >/dev/null 2>&1 &); exit; ;;
    "agenda") (nohup terminator -m -l agenda >/dev/null 2>&1 &); exit; ;;
    *)      echo "Unable to find layout '$1'" ;;
  esac
}

tutorial() {
  file="${HOME}/dotfiles/tutorials/${1}.md"
  echo "${file}";
  if [ -e "${file}" ] ; then
    less "${file}"
  else
    echo "'$1' tutorial not found"
  fi
}

alias r='reset'

# list

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# colors!

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# readable

alias df='df -h'
alias du='du --si'

# common errors
alias tailf='tail -f'
alias tail-f='tail -f'
alias les='less'
alias shh='ssh'
alias gerp='grep'
alias cd..='cd ..'
alias got='git'
alias qgit='git' #git diff, q, again...

# vagrant

alias v='vagrant'
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vatom='atom .; vup; vssh; cd /vagrant/'

# node

alias g='grunt'

# php

alias killphps='pgrep php | xargs kill -9'

# git
alias github-on='export GIT_AUTHOR_NAME=llafuente; export GIT_COMMITTER_NAME=llafuente; export GIT_AUTHOR_EMAIL=llafuente@noboxout.com; export GIT_COMMITTER_EMAIL=llafuente@noboxout.com;'
alias github-off='export GIT_AUTHOR_NAME=; export GIT_COMMITTER_NAME=; export GIT_AUTHOR_EMAIL=; export GIT_COMMITTER_EMAIL=;'

# misc
# list las modification of file/path ($1)
alias last-mod='find $1 -type f -exec stat --format "%Y :%y %n" "{}" \; | sort -nr | cut -d: -f2- | head'
alias rtail='reset; tail -f -n 0' # usage: rtail <file>

# bash completion staff
if [ -s /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi
if [ -s /etc/bash_completion.d/git ]; then
  source /etc/bash_completion.d/git
fi

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# print some info if shell
# only if shell, because otherwise rsync will fail with:
# protocol version mismatch -- is your shell clean?
if echo "$-" | grep i > /dev/null; then
  echo "HOME IS: $HOME"
  echo -ne "Current date: "; date
  echo -ne "uptime: "; uptime
fi

