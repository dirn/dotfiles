bootstrap: install install-homebrew install-homebrew-extras \
	   install-homebrew-packages install-python install-heroku

install: install-vim install-git install-zsh install-ssh \
	 install-terminal-settings install-virtualenvwrapper install-mongo

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
	brew install git hub imagemagick legit macvim memcached mercurial \
		     mongodb node postgresql readline redis rhino ruby sqlite \
		     vim wget
	# spell check
	brew install aspell --with-lang-en

install-mongo:
	(cd mongo/submodules/mongo-hacker && $(MAKE) install)

install-pip:
	+@[ -d $(~/.pip $@) ] || mkdir -p $(~/.pip $@)
	rm -f ~/.pip/pip.conf
	ln -s `pwd`/pip/pip.conf ~/.pip/pip.conf

install-python:
	# easy_install will try to install the pip folder
	(cd git && easy_install pip)
	pip install bpython fabric sphinx virtualenv virtualenvwrapper

install-ssh:
	rm -f ~/.ssh/config
	ln -s `pwd`/ssh/config ~/.ssh/config

install-terminal-settings:
ifeq ($(shell uname),Darwin)
	cp ~/Library/Preferences/com.apple.Terminal.plist \
	    terminal/old-settings.bak
	cp terminal/com.apple.Terminal.plist ~/Library/Preferences
endif

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
	rm -f ~/.zshrc
	ln -s `pwd`/zsh/aliases ~/.aliases
	ln -s `pwd`/zsh/exports ~/.exports
	ln -s `pwd`/zsh/functions ~/.functions
	ln -s `pwd`/zsh/zshrc ~/.zshrc

dump-terminal-settings:
	cp ~/Library/Preferences/com.apple.Terminal.plist terminal
	plutil -convert xml1 terminal/com.apple.Terminal.plist
