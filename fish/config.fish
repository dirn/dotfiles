# Add the local bin folder (e.g., single-command virtual environments) to $PATH.
setenv PATH $PATH ~/.local/bin

# Vim all the things!
fish_vi_key_bindings

if test -e ~/.config/fish/extras.fish
    source ~/.config/fish/extras.fish
end

# Path to Oh My Fish install.
set --global --export OMF_PATH "/Users/dirn/.local/share/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
