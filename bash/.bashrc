if [[ $- != *i* ]]; then
    # Shell is non-interactive.
    return
fi

# XDG Base Directories
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

if test -z "${XDG_RUNTIME_DIR}"; then
    XDG_RUNTIME_DIR=$(mktemp -d "/tmp/${UID}-runtime-dir.XXX")
    export XDG_RUNTIME_DIR
fi

mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

# Helpers to add to PATH without duplication.
path_append() {
    if [[ ":$PATH:" != *":$1:"* ]] && [ -d "$1" ]; then
        export PATH="${PATH:+"$PATH:"}$1"
    fi
}

path_prepend() {
    if [[ ":$PATH:" != *":$1:"* ]] && [ -d "$1" ]; then
        export PATH="$1${PATH:+":$PATH"}"
    fi
}

# App-specific XDG paths.
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

export VCPKG_ROOT="${HOME}/repos/vcpkg"
path_prepend "$VCPKG_ROOT"

export EDITOR=nvim

# History configuration.
mkdir -p "$XDG_STATE_HOME/bash"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
HISTCONTROL="ignoreboth:erasedups"
HISTFILESIZE=131072
HISTSIZE=524288
HISTTIMEFORMAT="%F %T "

# Shell behavior
shopt -s autocd cdspell dirspell 2>/dev/null

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set mark-symlinked-directories on"
bind "set show-all-if-ambiguous on"

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# Aliases
if [ -f "$XDG_CONFIG_HOME/bash/aliases.sh" ]; then
    source "$XDG_CONFIG_HOME/bash/aliases.sh"
fi

# Local bin
path_prepend "$HOME/.local/bin"

# Starship Prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
