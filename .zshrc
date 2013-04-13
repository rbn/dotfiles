PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="vi ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/home/rich/.rvm/gems/ruby-1.9.3-p194/bin:/home/rich/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/rich/.rvm/rubies/ruby-1.9.3-p194/bin:/home/rich/.rvm/bin:/opt/local/bin:/opt/local/sbin:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin:/opt/local/lib/mysql5/bin:/home/rich/bin:/usr/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:~/.gem/ruby/1.8/bin:/usr/local/pgsql/bin:/Library/PostgreSQL/8.3/bin:/home/rich/.rvm/bin


####################
# rbn customizations
####################

LS_COLORS="ow=01;36:di=01;36"
export LS_COLORS


alias s="screen"
alias sr="screen -r"
alias sl="screen -list"
alias chrome="google-chrome 2> /dev/null &"
alias pgadmin="pgadmin3 2> /dev/null &"
alias lynx="lynx google.com"

# terminal commands
alias ls="ls -alh --color"

# terminal sizing 
# (think - terminal wide, long, and full) 
# (requires xterm)
alias tw="resize -s 40 100"
alias tl="resize -s 100 80"

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:./
