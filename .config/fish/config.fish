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

# Add Homebrew to $PATH.
eval (/opt/homebrew/bin/brew shellenv)

# Add GNU command line tools to $PATH.
set brewfix (brew --prefix)
fish_add_path --path --prepend \
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
set --global --export HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile

# Install homerew/core and homebrew/cask via the API rather than cloning their
# repositories.
set --global --export HOMEBREW_INSTALL_FROM_API

# Set the location of the asdf configuration.
set --global --export ASDF_CONFIG_FILE ~/.config/asdf/config
set --global --export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME ~/.config/asdf/versions

# Use asdf to manage versions of things.
set asdffix (brew --prefix asdf)
if test -e $asdffix
    source $asdffix/asdf.fish
end

# PuDB is a nicer debugger than pdb.
set --global --export PYTHONBREAKPOINT "pudb.set_trace"

# Both Poetry and my fish configuration add the name of the current environment
# to the prompt. The only way to stop the former is to tell pyvenv not to do it.
# Fortunately I've been using virtualfish for my non-Poetry environments.
set --global --export VIRTUAL_ENV_DISABLE_PROMPT 1

# git is too long to type.
alias g git

# I'm used to using gh to work with GitHub. Why type more to work with GitLab?
alias gl glab

# I like using exa but all of my muscle memory is for ls aliases.
alias ls exa
alias la "exa --all"
alias ll "exa --long"
alias lt "exa --tree --ignore-glob='.git|.mypy_cache|*.pyc' --all"

# Use bat for manpages.
if type --no-functions --query bat
    set --global --export MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Configure fzf.
set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --glob="!.git/*" --glob="!.mypy_cache/*"'

fish_add_path --path --prepend "$HOME/.local/bin"

# Use direnv.
direnv hook fish | source

# Allow for system-specific configuration.
if test -e ~/.config/fish/extras.fish
    source ~/.config/fish/extras.fish
end

# Use tmux for all new sessions. This should be done last in case extras.fish
# changes $PATH in a way that affects tmux.
if type --query tmux
    if not set --query TMUX
        exec env tmux new-session
    end
end
