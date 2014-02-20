bootstrap: install install-homebrew install-homebrew-extras \
	   install-homebrew-packages install-python install-heroku \
	   install-prezto install-weechat

install: install-vim install-git install-zsh install-ssh \
	 install-pylint install-virtualenvwrapper install-mongo install-tmux

install-git:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-heroku:
	curl https://toolbelt.heroku.com/install.sh | sh

install-homebrew:
	-ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

install-homebrew-extras:
	# Taps
	-brew tap homebrew/versions
	-brew tap jingweno/gh
	-brew tap phinze/homebrew-cask
	brew install brew-cask
	# Services
	gem install lunchy

install-homebrew-packages:
	# Homebrew packages
	brew install python25 python26 python python32 python3 pypy
	-brew install gh git imagemagick legit memcached mercurial mongodb \
	    node postgresql readline reattach-to-user-namespace redis rhino \
	    ruby sqlite tmux wget
	# Spell check
	brew install aspell --with-lang-en
	# Vim with Python 3 support
	brew install vim --with-python3
	brew install macvim --with-python3
	# Make tmux awesomer
	gem install tmuxinator
	# IRC
	brew install weechat --with-aspell --with-perl --with-python --with-ruby

install-mongo:
	-rm mongo/submodules/mongo-hacker/mongo_hacker.js
	(cd mongo/submodules/mongo-hacker && $(MAKE))

install-pip:
	+@[ -d $(~/.pip $@) ] || mkdir -p $(~/.pip $@)
	rm -f ~/.pip/pip.conf
	ln -s `pwd`/pip/pip.conf ~/.pip/pip.conf

install-psql:
	rm -f ~/.psqlrc
	ln -s `pwd`/postgresql/psqlrc ~/.psqlrc

install-prezto:
	rm -rf ~/.zprezto
	ln -s `pwd`/zsh/submodules/prezto ~/.zprezto

install-pylint:
	rm -f ~/.pylintrc
	ln -s `pwd`/python/pylintrc ~/.pylintrc

install-python:
	# easy_install will try to install the pip folder
	(cd git && easy_install pip)
	pip install bpython fabric flake8 pep8 pep257 pip-tools pyflakes \
	    pylint sphinx virtualenv virtualenvwrapper
	# powerline currently isn't available on PyPI
	pip install git+git://github.com/Lokaltog/powerline

install-ssh:
	rm -f ~/.ssh/config
	ln -s `pwd`/ssh/config ~/.ssh/config

install-tmux:
	rm -f ~/.tmux.conf
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

install-virtualenvwrapper:
	+@[ -d $(~/.virtualenvs $@) ] || mkdir -p $(~/.virtualenvs $@)
	rm -f ~/.virtualenvs/postmkvirtualenv
	ln -s `pwd`/virtualenvs/postmkvirtualenv ~/.virtualenvs/postmkvirtualenv

install-zsh:
	rm -f ~/.aliases
	rm -f ~/.exports
	rm -f ~/.functions
	rm -f ~/.zlogin
	rm -f ~/.zlogout
	rm -f ~/.zpreztorc
	rm -f ~/.zprofile
	rm -f ~/.zshenv
	rm -f ~/.zshrc
	ln -s `pwd`/zsh/aliases ~/.aliases
	ln -s `pwd`/zsh/exports ~/.exports
	ln -s `pwd`/zsh/functions ~/.functions
	ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
	ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
	ln -s `pwd`/zsh/zpreztorc ~/.zpreztorc
	ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
	ln -s ~/.zprezto/runcoms/zshev ~/.zshenv
	ln -s `pwd`/zsh/zshrc ~/.zshrc

update-submodules:
	git submodule foreach git pull origin master
	git submodule update --init --recursive
