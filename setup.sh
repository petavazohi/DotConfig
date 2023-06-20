#!/bin/bash

export base=$(pwd)

# emacs
if [ ! -d ~/.emacs.d ]; then
    mkdir ~/.emacs.d
fi

cd ~/.emacs.d
if [ ! -f ~/emac.d/local.el ]; then
    cp ${base}/emacs/local.el .
fi

for ifile in ${base}/emacs/*
do
    ln -s ${ifile} .
done
ln -s ${base}/emacs/snippets/ .


# tmux
cd ~
ln -s ${base}/tmux/.tmux.conf .
if [ ! -f ~/.tmux.local.conf ]; then
    cp ${base}/tmux/.tmux.local.conf .
fi

# bashrc
cd ~
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.old
    ln -s ${base}/bash/.bashrc .
fi

# Oh-my-posh
if [ ! -x ~/.local/bin/oh-my-posh ]; then
    if [ ! -d ~/.local/bin ]; then
        mkdir -p ~/.local/bin
    fi
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin/
fi
ln -s ${base}/.omp.json .

ln -s ${base}/bash/.bashrc.aliases .
ln -s ${base}/bash/.bashrc.functions .
ln -s ${base}/bash/.git-completion.bash .

if [ ! -f ~/.bashrc.local ]; then
    cp ${base}/bash/.bashrc.local .
fi

# ipython
if [ -d ~/.ipython/profile_default/startup/ ]; then
    cd ~/.ipython/profile_default/startup/
    ln -s ${base}/ipython/01-ipython.ipy .
    cd ~
fi

# matplotlib
if [ -d ~/.config/matplotlib ]; then
    cd ~/.config/matplotlib
    ln -s ${base}/matplotlibrc .
    cd ~
fi

cd ${base}

# github
ln -s ${base}/git/.git-completion.bash .
