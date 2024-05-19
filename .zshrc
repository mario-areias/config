### Zinit & ZSH plugins Configuration ###
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Initialize Zinit
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Install completions and load it
zinit light zsh-users/zsh-completions

# Load completions
autoload -Uz compinit && compinit

# fzf-tab needs to be loaded _before_ wrapper plugins and _after_ compinit
# https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#install
zinit light Aloxaf/fzf-tab

# wrapper plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# Helps speed up initial load time
# https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#calling-compinit-without-turbo-mode
zinit cdreplay -q

### Configuring fzf-tab ###

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing with cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

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
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

### Other Tools ###
eval "$(starship init zsh)"

eval "$(fzf --zsh)"

eval "$(zoxide init --cmd cd zsh)"

### Aliases ###

# Replace vim with nvim
alias vim='nvim'

# Replace ls with exa
alias ls="eza --icons=always --color=always"

# Replace cat wih bat
alias cat="bat"

# Added zellij aliases
source ~/.zellij_aliases
