# Disable the greeting.
set fish_greeting

# This is needed to fix CursorShape inside tmux. See
# https://github.com/neovim/neovim/issues/7067 which links to
# https://github.com/junegunn/fzf/issues/881#issuecomment-318576205.
function fish_vi_cursor
end

# Use Vim bindings.
fish_vi_key_bindings

# Use Neovim for all the things.
set --global --export EDITOR nvim
set --global --export VISUAL nvim

# Prompt before overwriting or removing a file.
alias cp "cp -i"
alias ln "ln -i"
alias mv "mv -i"
alias rm "rm -i"

# Create intermediate directories.
alias mkdir "mkdir -p"

# Set XDG environment variables to their default values if not already set.
if not set --query XDG_CONFIG_HOME
    set --global --export XDG_CONFIG_HOME $HOME/.config
end
if not set --query XDG_DATA_HOME
    set --global --export XDG_DATA_HOME $HOME/.local/share
end
if not set --query XDG_STATE_HOME
    set --global --export XDG_STATE_HOME $HOME/.local/state
end
if not set --query XDG_DATA_DIRS
    set --global --export XDG_DATA_DIRS /usr/local/share/:/usr/share/
end
if not set --query XDG_CONFIG_DIRS
    set --global --export XDG_CONFIG_DIRS /etc/xdg
end
if not set --query XDG_CACHE_HOME
    set --global --export XDG_CACHE_HOME $HOME/.cache
end
if not set --query XDG_RUNTIME_DIR
    if not set --query UID
        set --function UID (id -u (whoami))
    end
    set --global --export XDG_RUNTIME_DIR /run/user/$UID
end

# Add Homebrew to $PATH.
set --local architecture (uname -m)
switch $architecture
    case arm64
        eval (/opt/homebrew/bin/brew shellenv)
        fish_add_path --prepend /opt/homebrew/bin /opt/homebrew/sbin
    case "*"
        eval (/usr/local/bin/brew shellenv)
end

# Add GNU command line tools to $PATH.
set brewfix (brew --prefix)
fish_add_path --append \
    "$brewfix/opt/file-formula/bin" \
    "$brewfix/opt/m4/bin" \
    "$brewfix/opt/unzip/bin" \
    "$brewfix/opt/ed/libexec/gnubin" \
    "$brewfix/opt/gnu-indent/libexec/gnubin" \
    "$brewfix/opt/gnu-sed/libexec/gnubin" \
    "$brewfix/opt/gnu-tar/libexec/gnubin" \
    "$brewfix/opt/gnu-which/libexec/gnubin" \
    "$brewfix/opt/grep/libexec/gnubin" \
    "$brewfix/opt/make/libexec/gnubin"

# Manage Homebrew formulae.
set --global --export HOMEBREW_BUNDLE_FILE $XDG_CONFIG_HOME/brew/Brewfile

# Make sure the right OpenSSL is used when installing Python.
set opensslfix (brew --prefix openssl)
set --global --export LDFLAGS "-L$opensslfix/lib"
set --global --export CPPFLAGS "-I$opensslfix/include"
set --global --export PKG_CONFIG_PATH "$opensslfix/lib/pkgconfig"

if type --query rtx
    rtx activate fish | source
    set --global --export RTX_PYTHON_DEFAULT_PACKAGES_FILE $XDG_CONFIG_HOME/rtx/default_python_packages
end

# PuDB is a nicer debugger than pdb.
set --global --export PYTHONBREAKPOINT "pudb.set_trace"

# git is too long to type.
alias g git

# I'm used to using gh to work with GitHub. Why type more to work with GitLab?
alias gl glab

# I like using exa but all of my muscle memory is for ls aliases.
alias ls exa
alias la "exa --all"
alias ll "exa --long"
alias tree "exa --tree --ignore-glob='.git|.mypy_cache|*.pyc' --all"

# Use bat for manpages.
if type --no-functions --query bat
    set --global --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Configure fzf.
set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --glob="!.git/*" --glob="!.mypy_cache/*"'

fish_add_path --prepend --move "$HOME/.local/bin"

# Use direnv.
direnv hook fish | source

# Allow for system-specific configuration.
if test -e $XDG_CONFIG_HOME/fish/extras.fish
    source $XDG_CONFIG_HOME/fish/extras.fish
end

# Use tmux for all new sessions. This should be done last in case extras.fish
# changes $PATH in a way that affects tmux.
if type --query tmux
    if not set --query TMUX
        exec env tmux new-session
    end
end
