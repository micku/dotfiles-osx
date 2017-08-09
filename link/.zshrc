#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=magenta'
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

eval $(gdircolors -b $HOME/.dircolors)

# Aliases
alias v=nvim
alias g=git
unalias lt

# Load custom functions
source ~/.zsh/func/functions

#This helper function will add a directory to the PATH if it exists
#This is a simple way to handle different machines, OSes, and configurations
add_path() {
    if [ -d "${1}" ]; then
        if [ -z "${PATH}" ]; then
            export PATH="${1}"
        else
            export PATH=$PATH:"${1}"
        fi
    fi
}

setup_path() {
  PATH=
  # Normal system stuff comes first for security
  # So npm packages can't override basic commands like ls

  # Homebrew
  add_path "/usr/local/bin"

  add_path "/bin"
  add_path "/usr/bin"
  add_path "/sbin"
  add_path "/usr/sbin"
  add_path "/usr/X11/bin"

  # Local pwd stuff
  add_path "${PWD}/script"
  add_path "${PWD}/bin"
  #  ...for node
  add_path "${PWD}/node_modules/.bin"
}
# Run this during shell startup.
# Can be re-run as needed manually as well
setup_path

if [ -n "${ZSH_VERSION}" ]; then
  chpwd() {
    [ -d .git -o \
      -d node_modules/.bin -o ] && setup_path
  }
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--reverse --inline-info"
#export FZF_DEFAULT_OPTS="--reverse --inline-info --preview 'head -100 {}'"
