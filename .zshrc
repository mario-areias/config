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

# Bat options
export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fzf catpuccing theme #
# https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Added Go binaries to Path
export PATH="$HOME/go/bin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"

# Added JDK for path
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME="$(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

# Added Visual studio binaries to PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Added CodeQL to Path
export PATH="$HOME/codeql:$PATH"

# Export .local/bin
export PATH="$HOME/.local/bin:$PATH"

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

### Zellij Key Binds ###

function zellij_up() {
  zellij action move-focus up
}

function zellij_down() {
  zellij action move-focus down
}

function zellij_left() {
  zellij action move-focus left
}

function zellij_right() {
  zellij action move-focus right
}

bindkey '^k' zellij_up
bindkey '^j' zellij_down
bindkey '^h' zellij_left
bindkey '^l' zellij_right

function zellij_keybindings() {
  # Here we define the custom widgets
  zvm_define_widget zellij_up
  zvm_define_widget zellij_down
  zvm_define_widget zellij_left
  zvm_define_widget zellij_right

  # In normal mode, we bind C-[h,j,k,l] to execute zellij command to move focus
  zvm_bindkey vicmd '^k' zellij_up
  zvm_bindkey vicmd '^j' zellij_down
  zvm_bindkey vicmd '^h' zellij_left
  zvm_bindkey vicmd '^l' zellij_right

  # In insert mode, we bind C-[h,j,k,l] to execute zellij command to move focus
  zvm_bindkey viins '^k' zellij_up
  zvm_bindkey viins '^j' zellij_down
  zvm_bindkey viins '^h' zellij_left
  zvm_bindkey viins '^l' zellij_right
}

# The plugin will auto execute this zvm_after_lazy_keybindings function
# Here we define custom widgets to be executed in normal and visual mode _only_.
function zvm_after_lazy_keybindings() {
  zellij_keybindings
}

# The plugin will auto execute this zvm_after_init function
# Here we define custom widgets to be executed in insert mode.
function zvm_after_init() {
  zellij_keybindings

  # Set up fzf key bindings and fuzzy completion
  # sourcing here because zsh vim mode overwrites Ctrl-R
  # https://github.com/jeffreytse/zsh-vi-mode/issues/242
  source <(fzf --zsh)
}

### Custom functions ###
# https://junegunn.github.io/fzf/tips/ripgrep-integration/
# ripgrep->fzf->vim [QUERY]
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf < /dev/null \
      --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)
