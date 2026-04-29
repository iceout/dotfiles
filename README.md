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

## 日常更新流程

这个仓库是个人 dotfiles，默认直接提交并 push 到 `origin/master`，不需要 PR。

先进入 chezmoi 的 source 目录，并同步远端：

```
chezmoi cd
git pull --ff-only
```

编辑配置文件：

```
chezmoi edit ~/.zshrc
```

也可以直接编辑 source 文件，例如 `dot_zshrc.tmpl`。

检查并应用到当前机器：

```
chezmoi diff ~/.zshrc
chezmoi apply ~/.zshrc
```

确认无误后提交并推送：

```
git status
git add dot_zshrc.tmpl
git commit -m "Update zshrc"
git push origin master
```

如果已经直接修改了真实文件，例如 `~/.zshrc`，用下面流程把改动导回 chezmoi source：

```
chezmoi diff ~/.zshrc
chezmoi add ~/.zshrc
chezmoi cd
git diff
git commit -am "Update zshrc"
git push origin master
```

只有在改动会影响多台机器且需要 review 时，才考虑开 PR。
