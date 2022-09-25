# Local variables that might be used in the rest of .zshenv
test "$UID" || UID=$(id -u)
test "$USER" || USER=$(id -un)
test "$HOSTNAME" || HOSTNAME=$(hostname)

# Path
test "$XDG_CACHE_HOME" || export XDG_CACHE_HOME="$HOME/.cache"
test "$XDG_CONFIG_HOME" || export XDG_CONFIG_HOME="$HOME/.config"
test "$XDG_DATA_HOME" || export XDG_DATA_HOME="$HOME/.local/share"
test "$XDG_RUNTIME_DIR" || export XDG_RUNTIME_DIR="$XDG_CACHE_HOME"
test "$XDG_BIN_HOME" || export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DESKTOP_DIR="$HOME/"

# Locale
export NAME="Hugo Pungs"
export EMAIL="dfxjnl@gmail.com"
export TZ="America/Recife"

# Preferred programs
export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="emacsclient -c"
export SUDO_EDITOR="nvim"

# Misc
export MAKEFLAGS="-j $(nproc)"
export NSS_DEFAULT_DB_TYPE="sql"
export SUDO_PROMPT="sudo password for %p@[30;43m%h[m: "

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
export ZGEN_DIR="$XDG_DATA_HOME/zgenom"

# Firefox - enable XInput2 for pixel-level scrolling
export MOZ_USE_XINPUT2="1"

# Firefox - EGL (on X11) and WebRender are mandatory for VA-API on X11
# https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration
export MOZ_X11_EGL="1"
export MOZ_WEBRENDER="1"

# Conform more programs to XDG conventions.
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en_US.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export PASSWORD_STORE_DIR="$HOME/.secrets/password-store"

export TMUX_HOME="$XDG_CONFIG_HOME/tmux"
export TMUXIFIER="$XDG_DATA_HOME/tmuxifier"
export TMUXIFIER_LAYOUT_PATH="$XDG_DATA_HOME/tmuxifier"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/config"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"
export NPM_CONFIG_PREFIX="$XDG_CACHE_HOME/npm"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node/repl_history"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export PIP_LOG_FILE="$XDG_DATA_HOME/pip/log"
export PYLINTHOME="$XDG_DATA_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

export PATH="$XDG_BIN_HOME:$TMUXIFIER/bin:$XDG_CONFIG_HOME/emacs/bin:$NPM_CONFIG_PREFIX/bin:$CARGO_HOME/bin:$PATH"

export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
[ -e ~/.Xauthority ] && mv -f ~/.Xauthority "$XAUTHORITY"

function _cache {
    (( $+commands[$1] )) || return 1
    local cache_dir="$XDG_CACHE_HOME/${SHELL##*/}"
    local cache="$cache_dir/$1"
    if [[ ! -f $cache || ! -s $cache ]]; then
        echo "Caching $1"
        mkdir -p $cache_dir
        "$@" >$cache
        chmod 600 $cache
    fi
    if [[ -o interactive ]]; then
        source $cache || rm -f $cache
    fi
}

function _source {
    for file in "$@"; do
        [ -r $file ] && source $file
    done
}

# Be more restrictive with permissions; no one has any business reading things
# that don't belong to them.
if (( EUID != 0 )); then
    umask 027
else
    # Be even less permissive if root.
    umask 077
fi
