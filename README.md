# dotfiles

Thanks for checking out my dotfiles. If you want to use them, feel free to clone
and repo and play around. If you want to setup up your computer with some useful
(at least to me) stuff, they can take care of that for you.

## Setup

This repository is inspired by the bare repository approach popularized in
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/. To add it to a new computer:

    $ git clone --bare https://gitlab.com/dirn/dotfiles.git $HOME/.cfg
    $ git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout
    $ git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no
