# STARTX
# if DISPLAY is not set, propose to start X11
if test -z ${DISPLAY}; then
    echo "press enter to start X, CTRL-C to abort."
    read anykey
    startx
fi

# TMUX
# if no session is started, start a new session
if test -z ${TMUX}; then
    tmux
fi
# when quitting tmux, try to attach
while test -z ${TMUX}; do
    tmux attach || break
done

# KEYS
# fix keys for zsh
if test -z ${TMUX}; then
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line
else
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
    bindkey "^[[5~" beginning-of-history
    bindkey "^[[6~" end-of-history
fi

# PROMPT
autoload -U promptinit
promptinit
prompt suse

# COMPLETION
zstyle ':completion:*' completer _complete _ignored _correct
zstyle :compinstall filename '/home/me/.zshrc'
autoload -Uz compinit
compinit

# HISTORY
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# SHELL OPTIONS
setopt correct correct_all appendhistory autocd extendedglob nomatch notify auto_pushd
unsetopt beep
bindkey -e

# LESS
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# SOME COLORS
eval "`dircolors -b`"
export LS_COLORS='di=38;5;108:fi=00:*svn-commit.tmp=31:ln=38;5;116:ex=38;5;186'
alias ls='ls --color=always'
alias dir='dir --color=always'
alias vdir='vdir --color=always'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias diff='colordiff'
alias less='less -R'

# LS
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# EDITOR
export VISUAL=vim
export EDITOR=vim
alias vi='vim'

# MANPAGES
export PAGER='less'
export LESSCHARSET=UTF-8
alias manlat='LESSCHARSET=latin9 man -C /etc/man-latin1.conf'

# MPD
export MPD_PORT=6600
export MPD_HOST='localhost'

# SCANIMAGE
alias scanimage='/usr/bin/scanimage --resolution 130'

# XRANDR
alias multiscreen='xrandr --output VGA --above LVDS'

# GDB
alias gdb='gdb -q'

# OPEN
alias open='gnome-open'

# FIX JAVA
export GDK_NATIVE_WINDOWS=true

# IRSSI IN TMUX
# switch to irssi session (and if necessary starts this session before)
irssi()
{
    if tmux has -t irssi >/dev/null; then
        tmux switch -t irssi
    else
        TMUX="" tmux new -d -s irssi /usr/bin/irssi
        tmux switch -t irssi
    fi
}

export PATH=/opt/android-sdk-linux_86/tools:${PATH}
export GUROBI_HOME=/opt/gurobi301/linux64/
