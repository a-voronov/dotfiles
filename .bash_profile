[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=vim

# Set CLICOLOR if you want Ansi Colors in iTerm2
# export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
# export TERM=xterm-256color

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.aliases ]; then
   source ~/.aliases
fi

