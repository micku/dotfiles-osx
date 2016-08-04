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
alias ls='ls -l --color --group-directories-first'

# Aliases
alias v=nvim
alias g=git

# Load custom functions
source ~/.zsh/func/functions
