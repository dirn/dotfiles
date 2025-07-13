function catppuccinup
    set --local flavors
    set -a flavors frappe
    set -a flavors latte
    set -a flavors macchiato
    set -a flavors mocha

    function capitalize
        echo $argv | sed 's/[^ _-]*/\u&/g'
    end

    echo "Updating Alacritty themes"
    for flavor in $flavors
        curl --silent --location --remote-name \
            --create-dirs --output-dir $XDG_CONFIG_HOME/alacritty \
            https://github.com/catppuccin/alacritty/raw/main/catppuccin-$flavor.toml
    end

    echo "Updating Alfred themes"
    for flavor in $flavors
        curl --silent --location --remote-name \
            --create-dirs --output-dir $XDG_CONFIG_HOME/alfred \
            https://raw.githubusercontent.com/catppuccin/alfred/main/dist/Catppuccin-macOS-$flavor.alfredappearance
    end

    echo "Updating bat themes"
    for flavor in $flavors
        curl --silent --location \
            --create-dirs --output "$(bat --config-dir)/themes/Catppuccin $(capitalize $flavor).tmTheme" \
            https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20$(capitalize $flavor).tmTheme
    end
    bat cache --build

    echo "Updating delta themes"
    curl --silent --location --remote-name \
        --create-dirs --output-dir $XDG_CONFIG_HOME/git \
        https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig

    echo "Updating fish themes"
    for flavor in $flavors
        curl --silent --location \
            --create-dirs --output "$XDG_CONFIG_HOME/fish/themes/Catppuccin $(capitalize $flavor).theme" \
            https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20$(capitalize $flavor).theme
    end

    echo "Updating Neomutt themes"
    curl --silent --location \
        --create-dirs --output $XDG_CONFIG_HOME/neomutt/catppuccin.muttrc \
        https://raw.githubusercontent.com/catppuccin/neomutt/main/neomuttrc
    curl --silent --location \
        --create-dirs --output $XDG_CONFIG_HOME/neomutt/catppuccin-latte.muttrc \
        https://raw.githubusercontent.com/catppuccin/neomutt/main/latte-neomuttrc
end
