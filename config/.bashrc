# ~/.bashrc — interactive shell setup

# Non-interactive shells (scripts, ly's setup.sh) stop here
[[ $- != *i* ]] && return

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'

# Shell behaviour
shopt -s checkwinsize   # update LINES/COLUMNS after each command
shopt -s autocd         # type a directory name to cd into it
shopt -s cdspell        # fix minor typos in cd
shopt -s globstar       # ** matches recursively

# Completion (pacman -S bash-completion)
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Prompt: user@host dir (git branch) $
__git_branch() {
    local b
    b=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    printf ' (%s)' "$b"
}
if [ "$EUID" -eq 0 ]; then
    PS1='\[\e[1;31m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[33m\]$(__git_branch)\[\e[0m\] # '
else
    PS1='\[\e[1;32m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[33m\]$(__git_branch)\[\e[0m\] \$ '
fi

# Colors
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias v='vim'
alias update='sudo pacman -Syu'
alias suckless='cd ~/suckless_setup'

# Personal aliases
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
