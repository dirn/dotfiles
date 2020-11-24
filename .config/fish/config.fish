# Disable the greeting.
set fish_greeting

# This is needed to fix CursorShape inside tmux. See
# https://github.com/neovim/neovim/issues/7067 which links to
# https://github.com/junegunn/fzf/issues/881#issuecomment-318576205.
function fish_vi_cursor; end

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
set --global --export PATH \
    "$brewfix/opt/file-formula/bin" \
    "$brewfix/opt/m4/bin" \
    "$brewfix/opt/unzip/bin" \
    "$brewfix/opt/ed/libexec/gnubin" \
    "$brewfix/opt/gnu-indent/libexec/gnubin" \
    "$brewfix/opt/gnu-sed/libexec/gnubin" \
    "$brewfix/opt/gnu-tar/libexec/gnubin" \
    "$brewfix/opt/gnu-which/libexec/gnubin" \
    "$brewfix/opt/grep/libexec/gnubin" \
    "$brewfix/opt/make/libexec/gnubin" \
    $PATH

# Manage Homebrew formulae.
set --global --export HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile

# Manage Python with pyenv.
if type --no-functions --quiet pyenv
    status --is-interactive; and source (pyenv init -|psub)
end

# PuDB is a nicer debugger than pdb.
set --global --export PYTHONBREAKPOINT "pudb.set_trace"

# git is too long to type.
alias g git

# Configure fzf.
set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --glob="!.git/*" --glob="!.mypy_cache/*"'

# Allow for system-specific configuration.
if test -e ~/.config/fish/extras.fish
    source ~/.config/fish/extras.fish
end

# Use tmux for all new sessions. This should be done last in case extras.fish
# changes $PATH in a way that affects tmux.
if type -q tmux 
    if not set -q TMUX; exec env tmux new-session; end
end
