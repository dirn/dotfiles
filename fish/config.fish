# Add the local bin folder (e.g., single-command virtual environments) to $PATH.
setenv PATH $PATH ~/.local/bin

# Disable the greeting.
set fish_greeting

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

# Path to Oh My Fish install.
set --global --export OMF_PATH "/Users/dirn/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
