# some code from https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
