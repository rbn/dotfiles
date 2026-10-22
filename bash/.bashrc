# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/nymanr/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="pure"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")
# You can also specify the list from which a theme is randomly selected:
# OMB_THEME_RANDOM_CANDIDATES=("font" "powerline-light" "minimal")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# To enable/disable Spack environment information
# OMB_PROMPT_SHOW_SPACK_ENV=true  # enable
# OMB_PROMPT_SHOW_SPACK_ENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# If you want to reduce the initialization cost of the "tput" command to
# initialize color escape sequences, you can uncomment the following setting.
# This disables the use of the "tput" command, and the escape sequences are
# initialized to be the ANSI version:
#
#OMB_TERM_USE_TPUT=no

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

####################################
### Customizations ###
####################################

export PATH="/opt/nvim/bin:$PATH"

# Added by Antigravity CLI installer
export PATH="/home/nymanr/.local/bin:$PATH"

# adding dev startup script
alias rm='rm -i'
alias ls='ls -al --color=auto'
alias vim='nvim'
alias dev="$HOME/scripts/start-dev.sh"
alias devb="nvim ~/.bashrc"
alias devc="cd ~/repos/learn-c/;ls"
alias devsub="cd ~/repos/subosc/;ls"
alias devwin="cd /mnt/c/Users/richn;ls"
alias devv="nvim ~/.config/nvim/init.lua"
alias devjobs="nvim ~/jobsearch.md"
alias sourceb="source ~/.bashrc"
alias cdsketch="cd ~/repos/sketch-tool/src/sketch-tool-web/"
alias resize="$HOME/scripts/resize-dev.sh"
alias ts="tmux kill-server"
alias cool="nvim ~/vimiscool.md ~/gitiscool.md"
alias fd='fdfind'

# shortcut for dev in C
ccrun() {
    if [[ -z "$1" ]]; then
        echo "Usage: ccrun <source.c> [-m]"
        return 1
    fi

    local src="$1"
    local exe="${src%.c}"
    local libs=""

    if [[ "$2" == "-m" ]]; then
        libs="-lm"
    fi

    gcc -std=gnu17 -Wall -Wextra -g "$src" -o "$exe" $libs &&
    "./$exe"
}

pyserve() {
  python3 -m http.server "${1:-8080}" --bind 127.0.0.1
}

# Check dotfiles once per day
# Daily dotfiles Git status reminder
if [[ $- == *i* && -d "$HOME/dotfiles/.git" ]]; then
    CHECK_FILE="$HOME/.cache/dotfiles-last-check"

    # Check once every 24 hours
    if [[ ! -f "$CHECK_FILE" ]] ||
       (( $(date +%s) - $(stat -c %Y "$CHECK_FILE") >= 86400 )); then

        if [[ -n "$(git -C "$HOME/dotfiles" status --porcelain)" ]]; then
            printf '\n\033[1;38;2;0;225;240m'
            cat <<'EOF'
+------------------------------------------+
|                                          |
|   !!  DOTFILES NEED ATTENTION  !!        |
|                                          |
|   Uncommitted changes detected           |
|                                          |
+------------------------------------------+

EOF
            printf '\033[0m'
            printf 'Review: git -C ~/dotfiles status\n\n'
            printf '\n\n'
        fi

        # Record the time of the last check
        mkdir -p "$HOME/.cache"
        touch "$CHECK_FILE"
    fi
fi
