# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/juan/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# Default text editor
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias update-lvim="git -C "/home/juan/.local/share/lunarvim/lvim/" pull;lvim +LvimUpdate +q"
alias f="ranger"
alias e="lvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Invoking GPG-AGENT
export GPG_TTY=$TTY

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GEM_HOME/bin"

#Setting up keyboard layout
setxkbmap -layout us -variant altgr-intl

#ESC <-> CAPSLOCK 
# setxkbmap -option caps:swapescape
