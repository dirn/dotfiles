bootstrap: install install-homebrew install-homebrew-extras \
	   install-homebrew-packages install-python install-heroku \
	   install-prezto

install: install-vim install-git install-zsh install-ssh \
	 install-virtualenvwrapper install-mongo install-tmux

install-git:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-heroku:
	curl https://toolbelt.heroku.com/install.sh | sh

install-homebrew:
	-curl -fsSkL raw.github.com/mxcl/homebrew/go | ruby

install-homebrew-extras:
	# Taps
	-brew tap homebrew/versions
	-brew tap phinze/homebrew-cask
	brew install brew-cask
	# Services
	gem install lunchy

install-homebrew-packages:
	# Homebrew packages
	brew install python25 python26 python python32 python3 pypy
	-brew install git hub imagemagick legit macvim memcached mercurial \
		      mongodb node postgresql readline \
		      reattach-to-user-namespace redis rhino ruby sqlite tmux \
		      vim wget
	# Spell check
	brew install aspell --with-lang-en
	# Make tmux awesomer
	gem install tmuxinator

install-mongo:
	-rm mongo/submodules/mongo-hacker/mongo_hacker.js
	(cd mongo/submodules/mongo-hacker && $(MAKE))

install-pip:
	+@[ -d $(~/.pip $@) ] || mkdir -p $(~/.pip $@)
	rm -f ~/.pip/pip.conf
	ln -s `pwd`/pip/pip.conf ~/.pip/pip.conf

install-prezto:
	rm -rf ~/.zprezto
	ln -s `pwd`/zsh/submodules/prezto ~/.zprezto

install-python:
	# easy_install will try to install the pip folder
	(cd git && easy_install pip)
	pip install bpython fabric pip-tools sphinx virtualenv virtualenvwrapper

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
	# Also update submodules with submodules
	(cd zsh/submodules/prezto && git submodule foreach git pull origin master)
