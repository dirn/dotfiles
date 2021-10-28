function retro --description "Sync retro games to an SD card"
    function _to_table --description "Output values in a table"
        set_color --bold blue
        echo $argv | column -t
        set_color normal
    end

    set --local options
    set options $options (fish_opt --short h --long help)
    set options $options (fish_opt --short s --long system --required-val)
    set options $options (fish_opt --short m --long method --required-val)
    argparse $options -- $argv

    if set --query _flag_help
        echo "Sync retro games to an SD card"
        echo

        set_color --bold
        echo "USAGE"
        set_color normal
        echo "  retro [OPTIONS]"
        echo

        set_color --bold
        echo "OPTIONS"
        set_color normal
        echo "  -h/--help         Display this help message."
        echo "  -s/--system       The system to sync."
        echo "  -m/--method       The method to use to sync."

        return 0
    end

    if test -z "$RETRO_GAMES"
        echo "\$RETRO_GAMES not set"
        return 1
    else if not test -e $RETRO_GAMES
        echo "'$RETRO_GAMES' not found"
        return 1
    end

    set --local source $RETRO_GAMES

    if not set --query _flag_system
        exa $source
        read --prompt-str "Which system would you like to sync? " _flag_system
    end
    if test -z $_flag_system; or not test -e "$source/$_flag_system"
        echo "'$_flag_system' not found"
        return 1
    end

    if not set --query _flag_method
        _to_table "sd ssh"
        read --prompt-str "How would you like sync? " _flag_method
    end

    switch $_flag_method
        case sd
            exa /Volumes
            read --prompt-str "Which volume would you like to use? " --global _volume

            if test -z $_volume; or not test -e "/Volumes/$_volume"
                echo "'$_volume' not found"
                return 1
            end

            set --global _destination "/Volumes/$_volume/$_flag_system"
        case "ssh"
            set --local hosts (grep "^Host .*\$" $HOME/.ssh/config | sed "s/Host //" | string split " ")
            _to_table $hosts
            read --prompt-str "Which host would you like to use? " --local host

            if not contains $host $hosts
                echo "'$host' not found"
                return 1
            end

            set --global _destination "$host:roms/$_flag_system"
        case "*"
            echo "'$_flag_method' is not a valid choice"
            return 1
    end

    rsync --verbose --update $source/$_flag_system/* $_destination
    set --erase _destination

    if test $_flag_method = "sd"
        dot_clean "/Volumes/$_volume"
        set --erase _volume
    end
end
