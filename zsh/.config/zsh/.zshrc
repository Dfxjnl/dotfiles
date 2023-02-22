#!/usr/bin/env zsh
source $ZDOTDIR/config.zsh

export PATH="$XDG_BIN_HOME:$TMUXIFIER/bin:$XDG_CONFIG_HOME/emacs/bin:$NPM_CONFIG_PREFIX/bin:$CARGO_HOME/bin:$HOME/.python_venv/bin:$PATH"

# NOTE Zgen is no longer maintained; zgenom is a maintained fork
if [ ! -d "$ZGEN_DIR" ]; then
    echo "Installing jandamm/zgenom"
    git clone https://github.com/jandamm/zgenom "$ZGEN_DIR"
fi
source $ZGEN_DIR/zgenom.zsh

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

if ! zgenom saved; then
    echo "Initializing zgenom"
    rm -f $ZDOTDIR/*.zwc(N) \
       $XDG_CACHE_HOME/zsh/*(N) \
       $ZGEN_INIT.zwc

    # NOTE Be extra careful about plugin load order, or subtle breakage can
    #   emerge. This is the best order I've sussed out for these plugins.
    zgenom load junegunn/fzf shell
    zgenom load jeffreytse/zsh-vi-mode
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load zsh-users/zsh-completions src
    zgenom load gentoo/gentoo-zsh-completions src
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-history-substring-search
    # zgenom load romkatv/powerlevel10k powerlevel10k
    zgenom load hlissner/zsh-autopair autopair.zsh

    zgenom save
    zgenom compile $ZDOTDIR
fi

## Bootstrap interactive sessions
if [[ $TERM != dumb ]]; then
    autoload -Uz compinit && compinit -u -d $ZSH_CACHE/zcompdump
    source $ZDOTDIR/keybinds.zsh
    source $ZDOTDIR/completion.zsh
    source $ZDOTDIR/aliases.zsh
    source $ZDOTDIR/prompt.zsh
    _cache tmuxifier init -
    _cache fasd --init posix-alias zsh-{hook,{c,w}comp{,-install}}
    autopair-init
fi


alias luamake=/home/hugo/git/sumneko_lua/3rd/luamake/luamake
