# config

This repo configures some common applications and files

## Install

brew install fzf

brew install zoxide

brew install stow

Download: [OxProto Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip)

Configure nvim [here](https://github.com/mario-areias/nvim)

## Run

This command will create symlinks from this repo to the home folder. It will created symlinks based on the folder structure. The `--ignore` command is to exclude the `.ignore` file to be symlinked. This is on the repo so that telescope can fuzzy find the .dotfiles.

stow --target=$HOME . --ignore=ignore
