export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/go/bin:$PATH"

# This is the path for my bins project so I can run the binaries easily
export PATH="$HOME/Projects/my-bins/target/debug/:$PATH"

export EDITOR="nvim"

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS

alias vim='nvim'

eval "$(starship init zsh)"

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
