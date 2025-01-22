if [[ $- != *i* ]]; then
  # Shell is non-interactive.  Be done now!
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

export HISTFILE="${XDG_STATE_HOME}/bash/history"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"

export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"

eval "$(starship init bash)"
