# config

## Load

Copy the files to the correct location:

```bash
cp alacritty.toml ~/.config/alacritty/alacritty.toml
```

```bash
cp starship.toml ~/.config/starship.toml
```

```bash
cp zshrc ~/.zshrc
```

```bash
cp zellij_aliases ~/.zellij_aliases
```

```bash
cp .tmux.conf ~/.tmux.conf
```

```bash
cp config.kdl ~/.config/zellij/config.kdl
```

## Save

Copy the files from the location to the repository:

```bash
cp ~/.config/alacritty/alacritty.toml alacritty.toml
```

```bash
cp ~/.config/starship.toml starship.toml
```

```bash
cp ~/.zshrc zshrc
```

```bash
cp ~/.zellij_aliases zellij_aliases
```

```bash
cp ~/.tmux.conf .tmux.conf
```

```bash
zellij setup --dump-config > config.kdl
```
