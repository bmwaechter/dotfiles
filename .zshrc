source ~/term_config/antigen/antigen.zsh

export TERM=xterm-256color

# Android SDK
export GRADLE=/opt/android-studio/gradle/gradle-3.2/bin
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$GRADLE
export PATH=$PATH:/home/ben/.gem/ruby/2.4.0/bin
export DATABASE_URL=postgres:///$(whoami)

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] &&
    [ -s $BASE16_SHELL/profile_helper.sh ] &&
    eval "$($BASE16_SHELL/profile_helper.sh)"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
#antigen bundle frmendes/geometry
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure

# Tell antigen that you're done.
antigen apply


