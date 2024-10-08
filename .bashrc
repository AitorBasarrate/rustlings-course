# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#For angular to work
export NODE_OPTIONS="--max-old-space-size=4024"

export BACK_ENV_PATH="/home/aitor/.virtualenvs/Biolan-3000"
export BACK_REPO_PATH="/home/aitor/Documentos/Proyectos/biolanglobal-back"
export GOLANG_PATH="/home/aitor/go"

export DB_HOST="20.50.166.32"
export BD_HOST_LOCAL="localhost"
export DB_PORT="5432"
export DB_USER="postgres"
export DB_CORE="core"
export DB_MEASURES="measures"
export DB_CUSTOMER_MEASURES="customer_measures"
export DB_NEW_DEV="new_developments"
export DB_BACKUP_DIR="/home/aitor/Documents/Projects/BD_DUMP"
export EDITOR=nvim
export VISUAL=nvim
export PATH="$PATH:/opt/nvim-linux64/bin"

# My Alias
alias gitlog="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)'"
alias gitcommit="git add .; git commit"
alias venv="source ~/virtualenv/bin/activate"
alias actions="black .; flake8; python manage.py test"
alias squash="git rebase -i --keep-base"
alias celery="celery -A biodigi worker -l INFO; celery -A biodigi beat -l INFO"
# Load Angular CLI autocompletion.
source <(ng completion script)

# Custom PS1
# Function to get the current branch
function parse_git_branch {
	git branch 2>/dev/null | grep '*' | sed 's/* //'
}

function parse_virtual_env {
	if [[ "$VIRTUAL_ENV" != "" ]]
	then
		echo "(`basename \"$VIRTUAL_ENV\"`)"
	fi
}

function set_bash_prompt {
	local exit_code=$?
	local reset_color="\[\033[00m\]"
	local red_color="\[\033[31m\]"
	local yellow_color="\[\033[33m\]"
	local bold_green_color="\[\033[1;32m\]"
	local bold_magenta_color="\[\033[1;35m\]"
	local git_branch=""
	local venv="${bold_magenta_color}$(parse_virtual_env)${reset_color}"

	if git rev-parse --is-inside-work-tree &>/dev/null; then
		git_branch="${bold_green_color}[$(parse_git_branch)]${reset_color}"
	fi

	PS1="${venv}\W/${git_branch}\$ "
	#PS1="${debian_chroot:+($debian_chroot)}\[\e[0;31m\]\W/\[\e[0m\]${git_branch}\$ ";
	return $exit_code
}

PROMPT_COMMAND=set_bash_prompt

