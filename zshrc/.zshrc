# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="/home/juan/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# Default text editor
export EDITOR='nvim'
export VISUAL='nvim'

# # Invoking GPG-AGENT
export GPG_TTY=$TTY

export PATH="$PATH:$HOME/.local/bin"

# Aliases
alias f="ranger"
alias e="nvim ."

#ESC <-> CAPSLOCK 
# setxkbmap -option caps:swapescape

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
source /usr/share/nvm/init-nvm.sh
eval "$(rbenv init -)"
