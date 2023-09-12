#####
# My aliases
#
# References
# - https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.vh7hhm6th
# - https://github.com/webpro/dotfiles/blob/master/system/.alias
# - https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh
#####

# directory aliases
alias -- -='cd -'
alias dirh='dirs -v'
dotdot=".."
for index ({1..9}); do
  alias "$index"="cd +${index}"
  alias -g "..$index"="$dotdot"
  dotdot+='/..'
done
unset index dotdot

# single character shortcuts - be sparing!
alias _=sudo
alias l=ls
alias o=open
alias g=git

# mask built-ins with better defaults
alias ping='ping -c 5'
alias vi=vim

GREP_EXCL=(.bzr CVS .git .hg .svn .idea .tox)
alias grep="${aliases[grep]:-grep} --exclude-dir={\${(j.,.)GREP_EXCL}}"

# more ways to ls
# alias ll='ls -lh'
# alias la='ls -lAh'
alias ldot='ls -ld .*'

# fix typos
alias quit='exit'
alias cd..='cd ..'
alias zz='exit'

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# date/time
alias timestamp="date '+%Y-%m-%d %H:%M:%S'"
alias datestamp="date '+%Y-%m-%d'"
alias isodate="date +%Y-%m-%dT%H:%M:%S%z"
alias utc="date -u +%Y-%m-%dT%H:%M:%SZ"
alias unixepoch="date +%s"

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# disk usage
alias biggest='du -s ./* | sort -nr | awk '\''{print $2}'\'' | xargs du -sh'
alias dux='du -x --max-depth=1 | sort -n'
alias dud='du -d 1 -h'
alias duf='du -sh *'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd $ZDOTDIR'
alias fdot='cd ${XDG_CONFIG_HOME:-$HOME/.config}/fish'
alias cls="clear && printf '\e[3J'"

# echo things
alias print-fpath='for fp in $fpath; do echo $fp; done; unset fp'
alias print-path='echo $PATH | tr ":" "\n"'
alias print-functions='print -l ${(k)functions[(I)[^_]*]} | sort'

# auto-orient images based on exif tags
alias autorotate="jhead -autorot"

# set initial working directory
IWD=${IWD:-$PWD}
alias iwd='cd $IWD'

# dotfiles
alias dotf='cd "$DOTFILES"'
alias dotfed='cd "$DOTFILES" && ${VISUAL:-${EDITOR:-vim}} .'

# java
alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

# python
alias py2='python2'
alias py3='python3'
alias py='python3'
alias pip2update="pip2 list --outdated | cut -d ' ' -f1 | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pipup="pip3 list --outdated | cut -d ' ' -f1 | xargs -n1 pip3 install -U"
alias pyfind='find . -name "*.py"'
alias pygrep='grep --include="*.py"'
alias pyva="source .venv/bin/activate"

# todo-txt
alias t="todo.sh"
alias todos="$VISUAL $HOME/Desktop/todo.txt"


# ------------------------------------ Git ----------------------------------- #
## cfg alias for my dotfiles bare repo
alias cfg='/usr/bin/git --git-dir=/Users/ludovic/.cfg/ --work-tree=/Users/ludovic'
## Override gcm="git checkout $(git_main_branch)"
alias gcm="git checkout $(git_main_branch) && git pull"
## Override gcd="git checkout $(git_develop_branch)"
alias gcd="git checkout $(git_develop_branch) && git pull"
## Stash
alias gstm="git stash push -m"
alias gstwip="git stash push -m \"wip\""
## branch
alias gbv='git branch -vv'
# ----------------------------------- Conda ---------------------------------- #
alias cact="conda activate"
alias cdact="conda deactivate"
# ----------------------------------- Mongo ---------------------------------- #
alias mgstart="brew services start mongodb-community@5.0"
alias mgstop="brew services stop mongodb-community@5.0"
alias mgstatus="ps aux | grep -v grep | grep mongod"
# ---------------------------------- Docker ---------------------------------- #
alias dcupd="docker-compose up -d"
alias dcup="docker-compose up"
alias doc="docker-compose"
alias dlf="docker logs -f"
alias dlft="docker logs -f --tails 10"
# ----------------------------------- lerna ---------------------------------- #
alias lrun="lerna bootstrap && lerna run dev --stream"
# --------------------------------- Prettier --------------------------------- #
alias ptt="npx prettier --write"
# -------------------------------- Navigation -------------------------------- #
alias hhome="cd /Users/ludovic/HINFACT/"
alias proddev="\"/Users/ludovic/Library/CloudStorage/OneDrive-SharedLibraries-HINFACT/Hinfact - Interne - Knowledge Management/Product Development\""
# ----------------------------------- java ----------------------------------- #
alias tcprun="java -classpath bin/ SendOnTCP"
# ------------------------------------ Fun ----------------------------------- #
alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;33" grep --color "[^ ]"'
# git-of-theseus
alias stplot='git-of-theseus-stack-plot'
alias lplot='git-of-theseus-line-plot'
alias suplot='git-of-theseus-survival-plot'
