# paths
#Add brew packages dir to PATH
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# racket
if [ -e "/Applications/Racket/bin" ]; then
    export PATH="/Applications/Racket/bin:$PATH"
fi

# jenv
if [ -e "$HOME/.jenv/bin" ]; then
    # http://www.jenv.be
    # http://hanxue-it.blogspot.com/2014/05/installing-java-8-managing-multiple.html
    # TL;DR
    # Installing Java versions be like: `brew cask install java8`
    # Adding new version be like: `jenv add /Library/Java/JavaVirtualMachines/...`
    #
    # run `jenv enable-plugin export` to have JAVA_HOME env variable setup
    # run `jenv enable-plugin gradle` so that gradle works with jenv correctly
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# # android
if [ -e "$HOME/Library/Android/sdk" ]; then
    # ANDROID_HOME=$HOME/Library/Android/sdk
    # export ANDROID_HOME=$ANDROID_HOME
    # export PATH=$ANDROID_HOME/tools:$PATH
    # export PATH=$ANDROID_HOME/platform-tools:$PATH
fi

# rvm
if [ -e "$HOME/.rvm/bin" ]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
fi