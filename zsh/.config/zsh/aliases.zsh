alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
alias -- -='cd -'

alias q=exit
alias clr=clear
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias stow='stow -v'
alias du='du -h'
alias df='df -h'
alias sudo='sudo '

alias poweroff='sudo poweroff'
alias reboot='sudo reboot'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

if (( $+commands[exa] )); then
    alias ls="exa --group-directories-first --git"
    alias l="ls -blF"
    alias ll="ls -abghilmu"
    alias llm='ll --sort=modified'
    alias la="LC_COLLATE=C ls -ablF"
    alias tree='ls -tree'
fi

if (( $+commands[fasd] )); then
    # Fuzzy completion with 'z' when called without args
    unalias z 2>/dev/null
    function z {
	[ $# -gt 0 ] && _z "$*" && return
	cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
    }
fi

autoload -U zmv

# Emacs
e() { pgrep emacs && emacsclient -n "$@" || emacs -new "$@" }
ediff() { emacs -nw --eval "(ediff-files \"$1\" \"$2\")"; }
eman() { emacs -nw --eval "(switch-to-buffer (man \"$1\"))"; }
ekill() { emacsclient --eval '(kill-emacs'; }

# Git
g() { [[ $# = 0 ]] && git status --short . || git $*; }

alias cdg='cd `git rev-parse --show-toplevel`'
alias git='noglob git'
alias ga='git add'
alias gap='gid add --patch'
alias gb='git branch -av'
alias gop='git open'
alias gbl='git blame'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcf='git commit --fixup'
alias gcl='git clone'
alias gco='git checkout'
alias gcoo='git checkout --'
alias gf='git fetch'
alias gi='git init'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gll='git log --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gL='gl --stat'
alias gp='git push'
alias gpl='git pull --rebase --autostash'
alias gs='git status --short .'
alias gss='git status'
alias gst='git stash'
alias gr='git reset HEAD'
alias gv='git rev-parse'

if (( $+commands[fzf] )); then
    __git_log() {
	# format str implies:
	#  --abbrev-commit
	#  --decorate
	git log \
	    --color=always \
	    --graph \
	    --all \
	    --date=short \
	    --format="%C(bold blue)%h%C(reset) %C(green)%ad%C(reset) | %C(white)%s %C(red)[%an] %C(bold yellow)%d"
    }

    _fzf_complete_git() {
	ARGS="$@"

	# these are commands I commonly call on commit hashes.
	# cp->cherry-pick, co->checkout

	if [[ $ARGS == 'git cp'* || \
		  $ARGS == 'git cherry-pick'* || \
		  $ARGS == 'git co'* || \
		  $ARGS == 'git checkout'* || \
		  $ARGS == 'git reset'* || \
		  $ARGS == 'git show'* || \
		  $ARGS == 'git log'* ]]; then
	    _fzf_complete "--reverse --multi" "$@" < <(__git_log)
	else
	    eval "zle ${fzf_default_completion:-expand-or-complete}"
	fi
    }

    _fzf_complete_git_post() {
	sed -e 's/^[^a-z0-9]*//' | awk '{print $1}'
    }
fi

# tmux
alias ta='tmux attach'
alias tl='tmux ls'

if [[ -n $TMUX ]]; then # From inside tmux
    alias tf='tmux find-window'
    # Detach all other clients to this session
    alias mine='tmux detach -a'
    # Send command to other tmux window
    tt() {
      tmux send-keys -t .+ C-u && \
        tmux set-buffer "$*" && \
        tmux paste-buffer -t .+ && \
        tmux send-keys -t .+ Enter;
    }
    # Create new session (from inside one)
    tn() {
      local name="${1:-`basename $PWD`}"
      TMUX= tmux new-session -d -s "$name"
      tmux switch-client -t "$name"
      tmux display-message "Session #S created"
    }
  else # From outside tmux
    # Start grouped session so I can be in two different windows in one session
    tdup() { tmux new-session -t "${1:-`tmux display-message -p '#S'`}"; }
fi
