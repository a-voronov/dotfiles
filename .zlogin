# load aliases
if [ -f ~/.aliases ]; then
   source ~/.aliases
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
