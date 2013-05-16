install: install-vim install-git install-zsh install-ssh \
	 install-terminal-settings

install-git:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-ssh:
	rm -f ~/.ssh/config
	ln -s `pwd`/ssh/config ~/.ssh/config

install-terminal-settings:
ifeq ($(shell uname),Darwin)
	cp ~/Library/Preferences/com.apple.Terminal.plist terminal/old-settings.bak
	cp terminal/com.apple.Terminal.plist ~/Library/Preferences
endif

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

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
