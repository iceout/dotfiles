# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

这个仓库的目标是：用 chezmoi 管理 shell、nvim、开发工具配置；开发工具尽量交给 [mise](https://mise.jdx.dev/) 管理，而不是在每台机器上混用不同安装方式。

## 基本原则

- dotfiles source 在 `~/.local/share/chezmoi`。
- 新机器优先先装 `mise`，再通过 mise 安装 `chezmoi`、`neovim`、`uv`、`python` 等开发工具。
- 系统包管理器（apt/brew/port）主要用于系统依赖、桌面软件、服务或 mise 不适合管理的工具。
- 不直接在模板中依赖 `.chezmoi.hostname`，避免把真实系统 hostname 固化进 GitHub；用本机 chezmoi data 里的 `.hostname` 作为逻辑机器名。
- 加密文件使用 chezmoi + age，未配置 age identity 时可以先 apply 未加密文件。

## 新机器初始化

### 1. 安装 mise

Linux/macOS 通用安装方式：

```sh
curl https://mise.run | sh
```

把 mise 加入 shell。zsh 用户通常加入 `~/.zshrc`：

```sh
eval "$(~/.local/bin/mise activate zsh)"
```

当前 shell 立即生效：

```sh
eval "$(~/.local/bin/mise activate zsh)"
```

验证：

```sh
mise --version
```

### 2. 用 mise 安装基础工具

推荐先用 mise 管理 chezmoi 和常用开发工具：

```sh
mise use -g chezmoi@latest
mise use -g neovim@stable
mise use -g uv@latest
mise use -g python@latest
mise use -g zoxide@latest fzf@latest eza@latest
```

如果需要固定 Python 版本，例如 Python 3.14：

```sh
mise use -g python@3.14.5
```

验证：

```sh
chezmoi --version
nvim --version
uv --version
python --version
```

### 3. 设置 chezmoi 本机逻辑 hostname 和 age identity

不要把真实系统 hostname 当作模板判断条件。先创建本机私有配置；新机器也固定使用 `~/.config/chezmoi/age.txt` 保存本机 age 私钥：

```sh
mkdir -p ~/.config/chezmoi
chmod 700 ~/.config/chezmoi

if [ ! -f ~/.config/chezmoi/age.txt ]; then
  chezmoi age-keygen -o ~/.config/chezmoi/age.txt
  chmod 600 ~/.config/chezmoi/age.txt
fi

cat > ~/.config/chezmoi/chezmoi.toml <<'TOML'
umask = 0o022
encryption = "age"

[age]
identity = "~/.config/chezmoi/age.txt"
recipientsFile = "~/.local/share/chezmoi/age-recipients.txt"

[data]
hostname = "Volantis"
TOML
chmod 600 ~/.config/chezmoi/chezmoi.toml
```

把 `Volantis` 换成这台机器的逻辑名。已有命名风格包括：

- `Winterfell`
- `Braavos`
- `Pentos-M1`
- `Pentos-Int`
- `Volantis`
- `Oldtown`
- `Castle-Black`

这些名字是 chezmoi 的私有逻辑机器名，不需要等于真实系统 hostname。优先继续使用《冰与火之歌》/《权力的游戏》里的地点或组织名，避免把 VPS 厂商、地域或真实 hostname 固化进公开 dotfiles。

`umask = 0o022` 用于避免当前 shell 的 umask（例如 `0002`）导致 chezmoi diff 出现大量 `664/775` 权限噪音。

### 4. 初始化 dotfiles

只拉取 source，不立即 apply：

```sh
chezmoi init iceout
```

检查 source：

```sh
chezmoi source-path
chezmoi cd
git status
```

先看差异：

```sh
chezmoi diff --keep-going
```

确认没有异常后，再 apply。首次建议不要盲目全量 apply，可以先应用关键未加密文件：

```sh
chezmoi apply ~/.zshrc ~/.zimrc
```

确认 shell 正常后再考虑全量 apply：

```sh
chezmoi apply
```

## 常用工具

### chezmoi

安装/升级优先使用 mise：

```sh
mise use -g chezmoi@latest
```

常用命令：

```sh
chezmoi cd                       # 进入 source 目录
chezmoi diff                     # 查看所有差异
chezmoi diff ~/.zshrc            # 只看一个文件
chezmoi apply ~/.zshrc           # 只应用一个文件
chezmoi apply                    # 应用全部
chezmoi add ~/.zshrc             # 把真实文件导回 source
chezmoi edit ~/.zshrc            # 编辑 source 中对应文件
```

同步远端但不 apply：

```sh
chezmoi cd
git pull --ff-only
chezmoi diff --keep-going
```

### neovim

优先用 mise：

```sh
mise use -g neovim@stable
```

dotfiles 中的 nvim 配置位于：

```text
private_dot_config/nvim/
```

应用后目标路径是：

```text
~/.config/nvim/
```

### uv 和 Python

优先用 mise：

```sh
mise use -g uv@latest
mise use -g python@3.14.5
```

验证：

```sh
uv --version
python --version
python3 --version
```

### direnv

`~/.zshrc` 会启用 direnv：

```sh
eval "$(direnv hook zsh)"
```

如果系统没有 direnv，需要先安装。Debian/Ubuntu 可用：

```sh
sudo apt install direnv
```

也可以按机器习惯用其他方式安装。

### fzf / zoxide / eza

优先用 mise 统一管理：

```sh
mise use -g zoxide@latest fzf@latest eza@latest
```

`~/.zshrc` 会在初始化 Zim 之前启用 mise，这样 `zmodule iceout/exa` 能看到 mise 提供的 `eza`。

迁移旧安装时，建议先安装 mise 版本并验证：

```sh
which zoxide fzf eza
zoxide --version
fzf --version
eza --version
```

确认都走 mise 管理路径后，再按需清理旧的手动安装，例如旧的 `~/.local/bin/zoxide`、`~/.local/bin/eza` 或 `~/.fzf`。不要在 mise 版本验证前先删除旧安装。

说明：`eza-community/eza` 是 eza 的真正上游项目；`mise-plugins/mise-eza` 是 asdf/mise 插件适配层。日常安装直接使用 mise 的 `eza` 工具名即可。

## 加密文件（age）

仓库中有加密文件，例如：

```text
private_dot_config/shell/encrypted_aliases.age
private_dot_config/shell_gpt/encrypted_dot_sgptrc.age
```

约定：

- 每台机器只有自己的私钥，固定放在 `~/.config/chezmoi/age.txt`，权限 `600`，不要提交到仓库。
- 所有机器的 public recipient 放在仓库里的 `age-recipients.txt`，这个文件可以提交。
- `~/.config/chezmoi/chezmoi.toml` 用 `recipientsFile = "~/.local/share/chezmoi/age-recipients.txt"`，避免每台机器手动维护 recipients 列表。
- `umask = 0o022` 固定 chezmoi 目标权限，避免不同机器的 shell umask 导致 `664/775` 权限噪音。

未配置 age identity 时，`chezmoi diff/apply/status` 可能报：

```text
encryption not configured
```

这种情况下可以先只 apply 未加密文件：

```sh
chezmoi apply ~/.zshrc ~/.zimrc
```

### 新机器加入 age recipients

在新机器上生成本机 identity 并输出 public recipient：

```sh
chezmoi cd
scripts/age-new-host.sh
```

把输出的 `age1...` 复制到一台已经能解密当前仓库的机器上，追加到 `age-recipients.txt`，然后在那台旧机器上重新加密所有 `.age` 文件：

```sh
chezmoi cd
vim age-recipients.txt
scripts/age-rekey.sh
git diff --stat
git status --short
git add age-recipients.txt private_dot_config/shell/encrypted_aliases.age private_dot_config/shell_gpt/encrypted_dot_sgptrc.age
git commit -m "Add <hostname> age recipient"
git push origin master
```

回到新机器同步并验证：

```sh
chezmoi cd
git pull --ff-only
chezmoi decrypt ~/.local/share/chezmoi/private_dot_config/shell/encrypted_aliases.age >/dev/null
chezmoi status
chezmoi diff
```

如果验证通过，再处理加密文件和全量 apply。

## 日常更新流程

这个仓库是个人 dotfiles，默认直接提交并 push 到 `origin/master`，不需要 PR。

进入 source 并同步远端：

```sh
chezmoi cd
git pull --ff-only
```

编辑配置：

```sh
chezmoi edit ~/.zshrc
```

也可以直接编辑 source 文件，例如：

```text
dot_zshrc.tmpl
private_dot_config/nvim/init.lua
```

检查并应用：

```sh
chezmoi diff ~/.zshrc
chezmoi apply ~/.zshrc
```

提交并推送：

```sh
git status
git add <changed-files>
git commit -m "Update dotfiles"
git push origin master
```

如果已经直接修改了真实文件，例如 `~/.zshrc`，用下面流程把改动导回 chezmoi source：

```sh
chezmoi diff ~/.zshrc
chezmoi add ~/.zshrc
chezmoi cd
git diff
git commit -am "Update zshrc"
git push origin master
```

只有在改动会影响多台机器且需要 review 时，才考虑开 PR。
