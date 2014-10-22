bootstrap: install-homebrew \
	   install

install: install-languages \
	 install-databases \
	 install-irc \
	 install-ssh \
	 install-utils \
	 install-vcs \
	 install-vim \
	 install-zsh

install-databases: install-postgresql \
	install-mongo \
	install-sqlite

install-docker:
	brew install boot2docker
	brew install docker
	brew install fig

install-git:
	# CLI
	brew install git
	-brew tap jingweno/gh
	brew install gh
	-brew tap thoughtbot/formulae
	brew install gitsh
	# Config
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-go:
	brew install go

install-homebrew:
	-ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

install-irc: install-ruby
	# Spell check
	brew install aspell --with-lang-en
	brew install weechat --with-aspell --with-perl --with-python --with-ruby
	gem install terminal-notifier

install-javascript:
	brew install v8

install-languages: install-python \
	install-go \
	install-ruby \
	install-javascript

install-mercurial:
	brew install hg

install-mongo:
	brew install mongodb # For CLI access
	# Config
	-rm mongo/submodules/mongo-hacker/mongo_hacker.js
	(cd mongo/submodules/mongo-hacker && $(MAKE))

install-postgresql:
	brew install postgresql # For CLI access
	# Config
	rm -f ~/.psqlrc
	ln -s `pwd`/postgresql/psqlrc ~/.psqlrc

install-python:
	# Python
	brew install pyenv
	brew install pyenv-virtualenvwrapper
	brew install readline
	# pyenv version
	rm -f ~/.python-version
	ln -s `pwd`/python/python-version ~/.python-version
	# Pip
	+@[ -d $(~/.pip $@) ] || mkdir -p $(~/.pip $@)
	rm -f ~/.pip/pip.conf
	ln -s `pwd`/pip/pip.conf ~/.pip/pip.conf
	# virtualenvwrapper
	+@[ -d $(~/.virtualenvs $@) ] || mkdir -p $(~/.virtualenvs $@)
	rm -f ~/.virtualenvs/postmkvirtualenv
	ln -s `pwd`/virtualenvs/postmkvirtualenv ~/.virtualenvs/postmkvirtualenv
	# Utilities
	pip install bpython devpi fabric sphinx tox
	# Linters
	pip install flake8 pyflakes pep8 pep257 flake8-docstrings pylint
	# Miscellaneous
	pip install powerline-status

install-ruby:
	brew install rbenv
	brew install ruby-build
	# rbenv version
	rm -f ~/.rbenv/version
	ln -s `pwd`/rbenv/version ~/.rbenv/version

install-ssh:
	rm -f ~/.ssh/config
	ln -s `pwd`/ssh/config ~/.ssh/config

install-tmux: install-ruby
	# Tmux
	brew install tmux
	brew install reattach-to-user-namespace
	# Config
	rm -f ~/.tmux.conf
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
	# Make tmux awesomer
	gem install tmuxinator

install-utils: install-docker \
	       install-tmux
	brew install ag
	brew install tree
	brew install wget

install-vcs: install-git
	     install-mercurial

install-vim:
	brew install vim --with-python3 --with-lua
	brew install macvim --with-python3 --with-lua
	# Spell check
	brew install aspell --with-lang-en
	# Config
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

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
	# prezto
	rm -rf ~/.zprezto
	ln -s `pwd`/zsh/submodules/prezto ~/.zprezto
	ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
	ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
	ln -s `pwd`/zsh/zpreztorc ~/.zpreztorc
	ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
	ln -s ~/.zprezto/runcoms/zshev ~/.zshenv
	ln -s `pwd`/zsh/zshrc ~/.zshrc

update-submodules:
	git submodule foreach git pull origin master
	git submodule update --init --recursive
