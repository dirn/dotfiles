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

# Manage Python with pyenv.
if test -e $HOME/.pyenv
    set --global --export PYENV_ROOT $HOME/.pyenv
    set --global --export PATH $PYENV_ROOT/bin $PATH
    pyenv init - | source
end

# PuDB is a nicer debugger than pdb.
set --global --export PYTHONBREAKPOINT "pudb.set_trace"

# git is too long to type.
alias g git

# Use tmux for all new sessions.
if not set -q TMUX; exec env tmux new-session; end

# Configure fzf.
set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --glob="!.git/*" --glob="!.mypy_cache/*"'

# Manage my dotfiles.
alias config "git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
