#/bin/bash

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

# tmux
cd ~
ln -s ${base}/tmux/.tmux.conf .
if [ ! -f ~/.tmux.conf.local ]; then
    cp ${base}/tmux/.tmux.conf.local .
fi

# bashrc
cd ~
ln -s ${base}/bash/.bashrc .
if [ ! -f ~/.bashrc.local ]; then
    cp ${base}/tmux/.bashrc.local .
fi

