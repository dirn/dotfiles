function onion_link
    if test -z "$RETRO_BACKUPS"
        echo "\$RETRO_BACKUPS not set"
        return 1
    end
    if test -z "$ONION_GAMES"
        echo "\$ONION_GAMES not set"
        return 1
    end

    set --local CART_READER cartreader
    set --local EPILOGUE Epilogue
    set --local RETROARCH RetroArch

    set --local system $argv[1]
    # The systems here are grouped by the program used to create the backups.
    # The more often I use it, the higher up in the list it appears.
    switch $system
        case gb gba gbc
            set --global _dumper EPILOGUE
            set --global _extension $system
            set --global _destination (string upper $system)

        case gamegear
            set --global _dumper $CART_READER
            set --global _extension gg
            set --global _destination GG
        case genesis
            set --global _dumper $CART_READER
            set --global _extension md
            set --global _destination MD
        case mastersystem
            set --global _dumper $CART_READER
            set --global _extension sms
            set --global _destination MS
        case nes
            set --global _dumper $CART_READER
            set --global _extension nes
            set --global _destination FC
        case pcengine tg16
            set --global _dumper $CART_READER
            set --global _extension pce
            set --global _destination PCE
        case sega32x
            set --global _dumper $CART_READER
            set --global _extension 32x
            set --global _destination THIRTYTWOX
        case sfc snes
            set --global _dumper $CART_READER
            set --global _extension sfc
            set --global _destination SFC

        case pcenginecd
            set --global _dumper $RETROARCH
            set --global _extension chd m3u
            set --global _destination PCECD
        case psx
            set --global _dumper $RETROARCH
            set --global _extension chd m3u
            set --global _destination PS
        case segacd
            set --global _dumper $RETROARCH
            set --global _extension chd m3u
            set --global _destination SEGACD

        case "*"
            echo "'$argv' is an unknown system"
            return 1
    end

    pushd $RETRO_BACKUPS/$_dumper/$system
    for ext in $_extension
        rsync \
            --archive --verbose --progress \
            --copy-links --copy-dirlinks \
            --size-only \
            --delete \
            --exclude=.DS_Store --exclude="._*" \
            *.$ext $ONION_GAMES/$_destination/
    end
    popd

    set --erase _destination
    set --erase _dumper
    set --erase _extension

    echo "Done."
end
