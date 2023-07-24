alias refreshaudio='sudo pkill coreaudiod'# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"
#noop

#Sudo alias hack
alias sudo='sudo '
# Aliases
alias zshconfig="vim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias sshconfig="vim ~/.ssh/config"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ssh='ssh -A'
alias ll='ls -aoF'
alias la='ls -A'

# When sound isn't working properly with stero jack we need to kill the audio daemon
# OS will relaunch it and it should fix audio issues
alias refresh_audio='sudo pkill coreaudiod'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sbt)

source $ZSH/oh-my-zsh.sh

#export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOPRIVATE=bitbucket.org/tendosystems/*,bitbucket.org/jack-ramey/*

# Customize to your needs...
export PATH=$HOME/bin:/opt/homebrew/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:/usr/local/java/default/bin:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin:/Users/jackramey/Library/Python/3.8/bin:$PATH:$PATH


#History Settings
setopt inc_append_history
setopt no_share_history

#git settings
__git_files () {
    _wanted files expl 'local files' _files
}

export PATCHDIR=$HOME/patch
export NOW=$( date '+%F_%H:%M:%S' )

# Stop annoying autocorrect
unsetopt correct_all


autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws


