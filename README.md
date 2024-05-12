# config

This repo configures some common applications and files

## Install

```bash
brew install eza

brew install bat

brew install fzf

brew install zoxide

brew install stow

brew install tlrc

brew tap homebrew/cask-fonts
brew install --cask font-0xproto-nerd-font
```

Configure nvim [here](https://github.com/mario-areias/nvim)

## Run

This command will create symlinks from this repo to the home folder. It will created symlinks based on the folder structure. The `--ignore` command is to exclude the `.ignore` file to be symlinked. This is on the repo so that telescope can fuzzy find the .dotfiles.

stow --target=$HOME . --ignore=ignore
