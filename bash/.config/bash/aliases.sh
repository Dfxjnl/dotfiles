# Make file commands verbose.
alias cp='cp -v'
alias mv='mv -v'

# Display partitions space in human-readable format.
alias df='df -h'

# Prints disk usage per directory non-recursively, in human readable format.
alias du='du -h -d1'

# Creates directories recursively.
alias mkdir='mkdir -pv'

# Enable simple aliases to be sudo'ed.
alias sudo='sudo '

# Directory browsing.
alias la='ls -A'
alias ll='ls -hlA'

# Prints each $PATH entry on a separate line.
alias path='echo -e ${PATH//:/\\n}'

alias wget='wget --hsts-file=$XDG_DATA_HOME/wget-hsts'
