# dotfiles

personal dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

# 一些依赖

## fzf

Using homebrew

```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

Using git

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## zoxide

Using homebrew

```
brew install zoxide
```

Using the install script

```
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

## eza

Using homebrew

```
brew install eza
```

Using binary
```
wget https://github.com/eza-community/eza/releases/download/v0.15.3/eza_x86_64-unknown-linux-gnu.zip
```