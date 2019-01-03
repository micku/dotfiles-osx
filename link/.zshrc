#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

if [ "$TMUX" = "" ]; then tmux; fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#eval $(gdircolors -b $HOME/.dircolors)

# Aliases
alias v=nvim
alias g=git
#unalias lt
alias tree='tree -a -I "*.pyc|__pycache__|.git|.v|.pytest_cache"'

# Load custom functions
source ~/.zsh/func/functions

# Plugins via zplug
source $HOME/.zplug/init.zsh
zplug "lukechilds/zsh-nvm"
zplug load #--verbose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g "" -U --hidden'
export FZF_DEFAULT_OPTS="
    --reverse 
    --inline-info
    --color fg:188,hl:103,fg+:222,hl+:104
    --color info:183,prompt:110,spinner:107,pointer:167,marker:215
"

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=magenta'
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

#alias ctags="`brew --prefix`/bin/ctags"

#export DOCKER_HOST=tcp://0.0.0.0:2375

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
