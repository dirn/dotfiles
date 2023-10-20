function onion_link
    if test -z "$RETRO_BACKUPS"
        echo "\$RETRO_BACKUPS not set"
        return 1
    else if test -z "$ONION_GAMES"
        echo "\$ONION_GAMES not set"
        return 1
    end

    set --function CART_READER cartreader
    set --function EPILOGUE Epilogue
    set --function JOEY_LYNX JoeyLynx
    set --function RETROARCH RetroArch

    set --function system $argv[1]
    # The systems here are grouped by the program used to create the backups.
    # The more often I use it, the higher up in the list it appears.
    switch $system
        case gb gba gbc
            set --function _dumper EPILOGUE
            set --function _extension $system
            set --function _destination (string upper $system)
        case sgb
            set --function _dumper $EPILOGUE
            set --function _extension gb
            set --function _destination SGB
            set --function system gb

        case gamegear
            set --function _dumper $CART_READER
            set --function _extension gg
            set --function _destination GG
        case genesis
            set --function _dumper $CART_READER
            set --function _extension md
            set --function _destination MD
        case mastersystem
            set --function _dumper $CART_READER
            set --function _extension sms
            set --function _destination MS
        case msx
            set --function _dumper $CART_READER
            set --function _extension rom
            set --function _destination MSX
        case msx2
            set --function _dumper $CART_READER
            set --function _extension mx2 rom
            set --function _destination MSX
        case nes
            set --function _dumper $CART_READER
            set --function _extension nes
            set --function _destination FC
        case pcengine tg16
            set --function _dumper $CART_READER
            set --function _extension pce
            set --function _destination PCE
        case sega32x
            set --function _dumper $CART_READER
            set --function _extension 32x
            set --function _destination THIRTYTWOX
        case sfc snes
            set --function _dumper $CART_READER
            set --function _extension sfc
            set --function _destination SFC

        case pcenginecd
            set --function _dumper $RETROARCH
            set --function _extension chd m3u
            set --function _destination PCECD
        case psx
            set --function _dumper $RETROARCH
            set --function _extension chd m3u
            set --function _destination PS
        case segacd
            set --function _dumper $RETROARCH
            set --function _extension chd m3u
            set --function _destination SEGACD

        case atarilynx
            set --function _dumper $JOEY_LYNX
            set --function _extension lnx
            set --function _destination LYNX

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

    echo "Done."
end
