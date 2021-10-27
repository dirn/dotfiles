function retro --description "Sync retro games to an SD card"
    function _to_table --description "Output values in a table"
        set_color --bold blue
        echo $argv | column -t
        set_color normal
    end

    if test -z "$RETRO_GAMES"
        echo "\$RETRO_GAMES not set"
        return 1
    else if not test -e $RETRO_GAMES
        echo "'$RETRO_GAMES' not found"
        return 1
    end

    set --local source $RETRO_GAMES

    exa $source
    read --prompt-str "Which system would you like to sync? " --local system

    if test -z $system; or not test -e "$source/$system"
        echo "'$system' not found"
        return 1
    end

    _to_table "sd ssh"
    read --prompt-str "How would you like sync? " --local method

    switch $method
        case sd
            exa /Volumes
            read --prompt-str "Which volume would you like to use? " --global _volume

            if test -z $_volume; or not test -e "/Volumes/$_volume"
                echo "'$_volume' not found"
                return 1
            end

            set --global _destination "/Volumes/$_volume/$system"
        case "ssh"
            set --local hosts (grep "^Host .*\$" $HOME/.ssh/config | sed "s/Host //" | string split " ")
            _to_table $hosts
            read --prompt-str "Which host would you like to use? " --local host

            if not contains $host $hosts
                echo "'$host' not found"
                return 1
            end

            set --global _destination "$host:roms/$system"
        case "*"
            echo "'$method' is not a valid choice"
            return 1
    end

    rsync --verbose --update $source/$system/* $_destination
    set --erase _destination

    if test $method = "sd"
        dot_clean "/Volumes/$_volume"
        set --erase _volume
    end
end
