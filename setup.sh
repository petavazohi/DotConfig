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
ln -s ${base}/emacs/snippets/ .


# tmux
cd ~
ln -s ${base}/tmux/.tmux.conf .
if [ ! -f ~/.tmux.conf.local ]; then
    cp ${base}/tmux/.tmux.conf.local .
fi

# bashrc
cd ~
ln -s ${base}/bash/.bashrc .
ln -s ${base}/bash/.bashrc.aliases .
ln -s ${base}/bash/.bashrc.functions .
ln -s ${base}/bash/.git-completion.bash .

if [ ! -f ~/.bashrc.local ]; then
    cp ${base}/bash/.bashrc.local .
fi

# ipython
cd ~/.ipython/profile_default/startup/
ln -s ${base}/ipython/01-ipython.ipy .

# github
ln -s ${base}/git/.git-completion.bash .
