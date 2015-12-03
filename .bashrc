# common
source ~/.node
PATH=$PATH:$HOME/bin

# Add PIP
if [ -s ~/.local/bin ]; then
  PATH="$PATH:$HOME/.local/bin"
fi

# Add RVM to PATH for scripting
if [ -s ~/.rvm/bin ]; then
  PATH="$PATH:$HOME/.rvm/bin"
fi

# shell only
[ -n "$PS1" ] && source ~/.bash_profile;
