# shell only
[ -n "$PS1" ] && source ~/.bash_profile;
# sh with shell
[ -z "$PS1" ] && source ~/.bash_common;
