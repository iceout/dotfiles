# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias tmux="TERM=screen-256color-bce tmux"

alias ..="cd .."
alias ...="cd ../.."
fpyg() { if [ -n "$1" ]; then rgrep --color --include="*.py" "$1" ./; fi}
