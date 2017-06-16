# Add the local bin folder (e.g., single-command virtual environments) to $PATH.
set --global --export PATH $PATH ~/.local/bin

# Disable the greeting.
set fish_greeting

# Set the colors.
set fish_pager_color_progress cyan

# Vim all the things!
fish_vi_key_bindings

# Prompt before overwriting or removing a file.
alias cp "cp -i"
alias ln "ln -i"
alias mv "mv -i"
alias rm "rm -i"

# Create intermediate directories.
alias mkdir "mkdir -p"

if test -e ~/.config/fish/extras.fish
    source ~/.config/fish/extras.fish
end
