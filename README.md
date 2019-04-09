dotfiles
========

some personal config files.


Usage
-----

### zsh

    sudo apt-get install zsh
    chsh -s /bin/zsh
    sudo apt-get install git
    curl -L git.io/antigen > antigen.zsh

然后使用`_zshrc`文件即可


### tmux

将tmux配置文件放到用户主目录,记得修改tmux-powerline路径

    cp PATH\_TO\_FILE/.tmux.conf ~/

让tmux色彩更丰富：在~/.bashrc里面添加

    alias tmux="TERM=screen-256color-bce tmux"

当alias tmux="TERM=screen-256color-bce tmux"时，vim下Home和End键有问题，在vimrc里面添加如下代码可以解决

    """"""""""""""
    " tmux fixes "
    """"""""""""""
    " Handle tmux $TERM quirks in vim
    if $TERM =~ '^screen-256color'
        map <Esc>OH <Home>
        map! <Esc>OH <Home>
        map <Esc>OF <End>
        map! <Esc>OF <End>
    endif

### tmux_powerline

     ./generate_rc.sh
     mv ~/.tmux-powerlinerc.default ~/.tmux-powerlinerc
     #export TMUX_POWERLINE_SEG_WEATHER_LOCATION="2151330" #编辑.tmux-powerlinerc
