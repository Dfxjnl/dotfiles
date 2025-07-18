if [[ $- != *i* ]]; then
    # Shell is non-interactive.
    return
fi

# XDG Base Directories
if test -z "${XDG_RUNTIME_DIR}"; then
    XDG_RUNTIME_DIR=$(mktemp -d "${UID}-runtime-dir.XXX")
    export XDG_RUNTIME_DIR
fi

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"

export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

export VCPKG_ROOT="${HOME}/repos/vcpkg"
export PATH=$VCPKG_ROOT:$PATH

export EDITOR=nvim

# History configuration.
export HISTFILE="${XDG_STATE_HOME}/bash/history"

# ignoreboth = ignoredups + ignorespace:
#     - ignoredups: ignore consecutive duplicate commands.
#     - ignorespace: ignore commands with leading whitespace.
# erasedups: eliminate all previous duplicates.
HISTCONTROL="ignoreboth:erasedups"

# Larger history size.
HISTSIZE=524288     # 2 ^ 19
HISTFILESIZE=131072 # 2 ^ 17

# Use standard ISO 8601 timestamp.
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S
HISTTIMEFORMAT="%F %T "

# Enable incremental history search with up/down arrows.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Smarter tab-completion (readline bindings)

# If set to On, readline performs filename matching and completion in a case-insensitive fashion.
bind "set completion-ignore-case on"

# If set to On, and completion-ignore-case is enabled, readline treats hyphens (-) and underscores
# (_) as equivalent when performing case-insensitive filename matching and completion.
bind "set completion-map-case on"

# If set to On, completed names which are symbolic links to directories have a slash appended
# (subject to the value of mark-directories).
bind "set mark-symlinked-directories on"

# This alters the default behavior of the completion functions. If set to On, words which have more
# than one possible completion cause the matches to be listed immediately instead of ringing the
# bell.
bind "set show-all-if-ambiguous on"

# If this variable is set, and is an array, the value of each set element is executed as a command
# prior to issuing each primary prompt. If this is set but not an array variable, its value is used
# as a command to execute instead.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# Better directory navigation.

# If set, a command name that is the name of a directory is executed as if it were the argument to
# the cd command. This option is only used by interactive shells.
shopt -s autocd 2>/dev/null

# If set, minor errors in the spelling of a directory component in a cd command will be corrected.
# The errors checked for are transposed characters, a missing character, and one character too many.
# If a correction is found, the corrected filename is printed, and the command proceeds. This option
# is only used by interactive shells.
shopt -s cdspell 2>/dev/null

# If set, bash attempts spelling correction on directory names during word completion if the
# directory name initially supplied does not exist.
shopt -s dirspell 2>/dev/null

source "$XDG_CONFIG_HOME"/bash/aliases.sh

eval "$(starship init bash)"
