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

## mise

```
curl https://mise.run | sh
```

# chezmoi

安装 chezmoi 并更新配置文件

```
sudo port install chezmoi

chezmoi init --apply iceout
```

Or
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply iceout
```

更新本地git仓库，并看看有什么更新
```
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

没有密钥的时候也可以同步部分文件
```
# 示例：只同步 .zshrc 和 .zimrc 这两个未加密文件
chezmoi apply ~/.zshrc ~/.zimrc
```
