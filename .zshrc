# .zshrc
# Author: Casey Walker
# ---------------------------------------------------------------------------- #


# Key bindings
# ---------------------------------------------------------------------------- #
bindkey -e
bindkey '^R' history-incremental-pattern-search-backward


# Zsh history configuration
# ---------------------------------------------------------------------------- #
setopt bang_hist
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# Don't store `history` commands
setopt hist_no_store

setopt hist_no_functions
setopt hist_verify
setopt extended_history

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000


# Other miscellaneous things
# ---------------------------------------------------------------------------- #
unsetopt autocd extendedglob nomatch notify

# Use Helix as the default text editor.
export EDITOR=hx


# VCS command prompt setup
# ---------------------------------------------------------------------------- #
autoload -Uz vcs_info

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)%F{blue}%r%f'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST

PROMPT_USER='%F{green}%n%f%F{cyan}@%f%F{magenta}%M%f'
PROMPT_DIR='%F{blue}%~%f'
PROMPT_VCS='${vcs_info_msg_0_}'
PROMPT_EXIT_CODE='%(?.%F{green}%?%f.%F{red}%?%f)'

PROMPT="$PROMPT_USER $PROMPT_DIR $PROMPT_EXIT_CODE %# "
RPROMPT="$PROMPT_VCS"


# ALiases
# ---------------------------------------------------------------------------- #
alias hist='history 1'
alias pj="pijul"


# Path variable and environment variables
# ---------------------------------------------------------------------------- #
# Keep PATH and path entries unique (e.g. no duplicates).
typeset -U PATH path

DOT_LOCAL_DIR="${HOME}/.local"
DOT_ZIG_DIR="${HOME}/.zig"
DOT_CARGO_DIR="${HOME}/.cargo"
DOT_GO_DIR="${HOME}/.go"

# Custom install directories for binaries/executables that aren't installed by a
# package manager.
CUSTOM_BIN_DIRS=(
  "${DOT_LOCAL_DIR}/bin"
  "${DOT_ZIG_DIR}/bin"
  "${DOT_CARGO_DIR}/bin"
  "${DOT_GO_DIR}/bin"
)

# Prepend custom command/executable install directories to the path.
for bin_dir in ${CUSTOM_BIN_DIRS}; do
    if [[ -d "${bin_dir}" ]]; then
      path=("${bin_dir}" $path)
    fi
done

# Export environment variable for Zig to know where to look for libraries.
if [[ -d "$DOT_ZIG_DIR/lib" ]]; then
  export ZIG_LIB_DIR="$DOT_ZIG_DIR/lib"
fi

# TODO: check if this is not recommended, and fix it if it's not.
# Export `GOPATH` so Go puts installed binaries in the same binary directory as
# itself.
if [[ -d "$DOT_GO_DIR" ]]; then
  export GOPATH="${DOT_GO_DIR}/bin"
fi


if (( $+commands[foobar] )); then
  # Set up the shell for using `fnm` properly.
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Command completion scripts
# ---------------------------------------------------------------------------- #
# Add scripts to fpath (for things like rstup/cargo/poetry/etc.).
fpath+="${HOME}/.zfunc/completions"


# Zsh completion options
# ---------------------------------------------------------------------------- #
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' \
  completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' \
  list-prompt '%Sat %l (hit TAB for more, or the character to insert)%s'
zstyle ':completion:*' \
  matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e errors in correction'
zstyle ':completion:*' select-prompt '%Sscrolling active (at %l)%s'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit
