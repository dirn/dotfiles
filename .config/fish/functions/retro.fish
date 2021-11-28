function retro --description "Sync retro games to an SD card"
    function _to_table --description "Output values in a table"
        set_color --bold blue
        echo $argv | column -t
        set_color normal
    end

    set --local options
    set options $options (fish_opt --short h --long help)
    set options $options (fish_opt --short s --long system --multiple-vals)
    set options $options (fish_opt --short a --long sd --long-only)
    set options $options (fish_opt --short b --long ssh --long-only)
    set options $options (fish_opt --short d --long dest --required-val)
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
        echo "  --sd              Sync to an SD card."
        echo "  --ssh             Sync over SSH."
        echo "  -d/--dest         The volume or host to sync to."

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
        read --prompt-str "Which system would you like to sync? " _system
        set --append _flag_system $_system
    end
    for _system in $_flag_system
        if test -z $_system; or not test -e "$source/$_system"
            echo "'$_system' not found"
            return 1
        end
    end

    set --local method
    if set --query _flag_sd
        set method "sd"
    else if set --query _flag_ssh
        set method "ssh"
    end

    if not set --query method
        _to_table "sd ssh"
        read --prompt-str "How would you like sync? " method
    end

    switch $method
        case sd
            if not set --query _flag_dest
                exa /Volumes
                read --prompt-str "Which volume would you like to use? " _flag_dest
            end

            if test -z $_flag_dest; or not test -e "/Volumes/$_flag_dest"
                echo "'$_flag_dest' not found"
                return 1
            end

            set --global _destination "/Volumes/$_flag_dest/$_flag_system"
        case "ssh"
            set --local hosts (grep "^Host .*\$" $HOME/.ssh/config | sed "s/Host //" | string split " ")

            if not set --query _flag_dest
                _to_table $hosts
                read --prompt-str "Which host would you like to use? " _flag_dest
            end

            if not contains $_flag_dest $hosts
                echo "'$_flag_dest' not found"
                return 1
            end

            set --global _destination "$_flag_dest:roms/"
        case "*"
            echo "'$_flag_method' is not a valid choice"
            return 1
    end

    set --local _systems ""
    for _system in (string split " " $_flag_system | sort | uniq)
        set --append _systems "$source/./$_system/*"
    end
    rsync --progress --update --relative $_systems $_destination
    set --erase _destination

    if test $method = "sd"
        dot_clean "/Volumes/$_flag_dest"
    end
end
