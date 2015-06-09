# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

export INSTANCE_ID="lab01"

PS1="[\[\033[01;31m\]${LOGNAME}\[\033[00m\]@\[\033[01;32m\]${INSTANCE_NAME}\[\033[00m\] \[\033[01;36m\]\w\[\033[00m\]]"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

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

alias untar='tar -xvzf'

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

# comment errors
alias tailf='tail -f'
alias tail-f='tail -f'
alias les='less'
alias shh='ssh'

# vagrant

alias vshh='vagrant ssh'

# node

alias g='grunt'

# php

alias killphps='pgrep php | xargs kill -9'
