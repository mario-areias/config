### Environment Variables ###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added Go binaries to Path
export PATH="$HOME/go/bin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"

# Setting up Neovim as default editor
export EDITOR="nvim"


### Zsh History Configuration ###
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS


### Plugins ###
eval "$(starship init zsh)"

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"

### Aliases ###

# Replace vim with nvim
alias vim='nvim'

# Replace ls with exa
alias ls="eza --icons=always"

# Replace cd with z
alias cd="z"

# Replace cat wih bat
alias cat="bat"

# Added zellij aliases
source ~/.zellij_aliases
