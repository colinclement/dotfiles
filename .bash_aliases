alias ..='cd ..'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias ta='tmux attach -d'
alias tl='tmux list-sessions'
# Tunnel all traffic through jection
alias tnl='sshuttle -r colin@jection.lassp.cornell.edu 0/0'
alias open='xdg-open'
alias config='/usr/bin/git --git-dir=$HOME/.myconf --work-tree=$HOME'

function jsonecho {
    python -m json.tool $1 | less
}
