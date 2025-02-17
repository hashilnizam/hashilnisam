#######################################
#                                     #
# Termux bash.bashrc                  #
# Modified by: KNIGHTFALL             #
#                                     #
# Last modified: 2023/09/18           #
#                                     #
#######################################

#### Global variables #################

# User name
#change your user name here
user_name="hashilnisam"

# Default editor
editor="vim"

#### Environment variables ############

# `grep default` highlight color
export GREP_COLOR="1;32"

# Colored man
export MANPAGER="less -R --use-color -Dd+g -Du+b"

# EDITOR
export EDITOR=$editor
export SUDO_EDITOR=$editor
export VISUAL="vim"

# USER
export USER=$user_name

# Path
export ETC="/data/data/com.termux/files/usr/etc"

#### History settings #################

# append to the history file, don't overwrite it
shopt -s histappend

# load results of history substitution into the readline editing buffer
shopt -s histverify

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#### Autocompletion ###################

# cycle through all matches with 'TAB' key
bind 'TAB:menu-complete'

# necessary for programmable completion
shopt -s extglob

# cd when entering just a path
shopt -s autocd

#### Prompt ###########################
sym="㉿" #symbol of prompt
bar_cr="34" #color of bars
name_cr="37" #color of user & host
end_cr="37" #color of prompt end
dir_cr="36" #color of current directory

PS1='\[\033[0;${bar_cr}m\]┌──(\[\033[1;${name_cr}m\]${user_name}${sym}\h\[\033[0;${bar_cr}m\])-[\[\033[0;${dir_cr}m\]\w\[\033[0;${bar_cr}m\]]
\[\033[0;${bar_cr}m\]└─\[\033[1;${end_cr}m\]\$\[\033[0m\] '

#### Aliases ##########################

# enable color support of ls, grep, and ip, also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip -color'
fi

# common commands
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias lm='ls | more'
alias ll='ls -lFh'
alias la='ls -alFh --group-directories-first'
alias l1='ls -1F --group-directories-first'
alias l1m='ls -1F --group-directories-first | more'
alias lh='ls -ld .??*'
alias lsn='ls | cat -n'
alias mkdir='mkdir -p -v'
alias cp='cp --preserve=all'
alias cpv='cp --preserve=all -v'
alias cpr='cp --preserve=all -R'
alias cpp='rsync -ahW --info=progress2'
alias cs='printf "\033c"'
alias q='exit'
alias c='clear'
alias count='find . -type f | wc -l'
alias fbig="find . -size +128M -type f -printf '%s %p\n'| sort -nr | head -16"
alias randir='mkdir -p ./$(cat /dev/urandom | tr -cd 'a-z' | head -c 4)/$(cat /dev/urandom | tr -cd 'a-z' | head -c 4)/'

# memory/CPU
alias df='df -Tha --total'
alias free='free -mt'
alias psa='ps auxf'
alias cputemp='sensors | grep Core'

# applications shortcuts
alias myip='curl -s -m 5 https://ipleak.net/json/'
alias e=$editor
alias p='python3'
alias kalilinux='vncserver :1 -geometry 1080x1920'
alias w3mduck='w3m https://duckduckgo.com'
alias ngrok='/data/data/com.termux/files/home/./ngrok'
alias edit-bashrc=$editor' /data/data/com.termux/files/usr/etc/bash.bashrc'
alias timenow='date +"%T"'
alias datenow='date +"%d-%m-%Y"'
alias untar='tar -zxvf '
alias wget='wget -c '
alias genpass='openssl rand -base64 12'
alias phttp='python -m http.server 8000'
alias kn='python /data/data/com.termux/files/home/keynote/keynote.py' # https://github.com/knightfall-cs/keynote

# --------------------------------
# ADVANCED ALIASES
# --------------------------------
alias sniff='tcpdump -i any -n'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3'
alias ipinfo='curl -s ipinfo.io'
alias netstatus='termux-wake-lock; while :; do ifconfig; sleep 5; done'
alias diskusage='df -h'
alias freespace='df -h | grep /data'

# --------------------------------
# BACKUP & SYNC
# --------------------------------
alias rsyncbackup='rsync -av --progress'
alias backup-dotfiles='tar -czvf ~/dotfiles_backup.tar.gz ~/.bashrc ~/.vimrc ~/.zshrc'

# --------------------------------
# PYTHON UTILITIES
# --------------------------------
alias p='python3'
alias localserver='python -m http.server 8080'

# --------------------------------
# GIT SHORTCUTS
# --------------------------------
alias g='git'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias gsync='git pull && git push'
alias gclean='git clean -fdx'

# --------------------------------
# FUN TOOLS
# --------------------------------
alias matrix='cmatrix'  # Install: `pkg install cmatrix`
alias nyancat='nyancat'  # Install: `pkg install nyancat`
alias cowsay='cowsay'  # Install: `pkg install cowsay`
alias fortune='fortune'  # Install: `pkg install fortune`

#### Functions ########################

# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestion.
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
    command_not_found_handle() {
        /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
    }
fi

# nnn "cd on quit"
n() {
    if [ -n $NNNVL ] && [ "${NNNVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# Enhanced recursive file search
function findf() {
    find . -type f -name "*$1*"
}

function findd() {
    find . -type d -name "*$1*"
}

# Monitor CPU and memory in real-time
function sysmon() {
    while :; do
        clear
        echo "---- CPU Usage ----"
        top -b -n 1 | head -5
        echo ""
        echo "---- Memory Usage ----"
        termux-meminfo | head -n 10
        sleep 3
    done
}

# Fetch and display file download progress
function fetch() {
    wget -c "$1" -P "${2:-.}" --show-progress
}

# Extract various archive formats
function extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.tar.xz) tar xf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.zip) unzip "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "Cannot extract: unknown file type '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Generate a random password
function genpass() {
    local length="${1:-12}"
    openssl rand -base64 "$length" | head -c "$length"
    echo
}

# Create a directory and immediately navigate into it
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Backup Termux home directory
function backup_home() {
    tar -czvf termux_home_backup_$(date +%F).tar.gz ~/
}

# Restore Termux home directory
function restore_home() {
    tar -xzvf "$1" -C ~/
}

# Monitor network connections
function netmon() {
    while :; do
        clear
        netstat -tuln
        sleep 5
    done
}

# List the largest files in the current directory
function bigfiles() {
    find . -type f -exec du -h {} + | sort -rh | head -n "${1:-10}"
}

# Create a temporary file and open it in the default editor
function tempedit() {
    local tmpfile=$(mktemp ~/tmp.XXXXXX)
    $EDITOR "$tmpfile"
    echo "Temp file created: $tmpfile"
}

# Check port availability
function checkport() {
    nc -zv "$1" "$2"
}

# Watch logs in real-time
function watchlogs() {
    tail -f "$1"
}


#### Display ########################

echo -e "\e[0;37m"
clear
echo '                                                            '
echo '          ██╗  ██╗ █████╗ ███████╗██╗  ██╗██╗██╗     '
echo '          ██║  ██║██╔══██╗██╔════╝██║  ██║██║██║     '
echo '          ███████║███████║███████╗███████║██║██║     '
echo '          ██╔══██║██╔══██║╚════██║██╔══██║██║██║     '
echo '          ██║  ██║██║  ██║███████║██║  ██║██║███████╗'
echo '          ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝'
echo '                             /\                             '
echo '                            /  \                            '
echo '                           /    \                           '
echo '                          /      \                          '
echo '                         /   /\   \                         '
echo '                        /   /  \   \                        '
echo '                       /   /    \   \                       '
echo '                      /   /      \   \                      '
echo '                     /   /________\   \                     '
echo '                    /                  \                    '
echo '                   /____________________\                   '
echo '                  M  D  C  C  L  X  X  V I                  '
echo            
echo '          ███╗   ██╗██╗███████╗ █████╗ ███╗   ███╗'
echo '          ████╗  ██║██║██╔════╝██╔══██╗████╗ ████║'
echo '          ██╔██╗ ██║██║███████╗███████║██╔████╔██║'
echo '          ██║╚██╗██║██║╚════██║██╔══██║██║╚██╔╝██║'
echo '          ██║ ╚████║██║███████║██║  ██║██║ ╚═╝ ██║'
echo '          ╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝'
echo
echo
echo

