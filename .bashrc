# PATH variables

export PATH="/usr/local/bin:/usr/local/sbin:$PATH" #Add brew packages dir to PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/lib/python2.7/site-packages"

BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Powerline setup
export TERM="screen-256color"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export POWERLINE_COMMAND=powerline
export POWERLINE_CONFIG_COMMAND=powerline-config
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

. "/usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
