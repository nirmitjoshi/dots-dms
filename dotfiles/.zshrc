eval "$(starship init zsh)"

# defaults
export EDITOR=helix
export VISUAL=helix

# path
export PATH="$PATH:$HOME/go/bin"

# aliases
alias hx=helix
alias ls='eza --all --classify --group-directories-first'
alias imv='imv -s shrink'
alias cp='cp -i'
alias mv='mv -i'
alias zd='zellij a -c default'

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# tools
eval "$(zoxide init zsh)"
export FZF_DEFAULT_COMMAND="fd --type f --type d --hidden"

# history
HISTSIZE=10000
SAVEHIST=500
HISTFILE="$HOME/.zsh_history"

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY
