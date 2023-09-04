function retro_link
    if test -z "$RETRO_BACKUPS"
        echo "\$RETRO_BACKUPS not set"
        return 1
        elif test -z "$RETRO_GAMES"
        echo "\$RETRO_GAMES not set"
        return 1
    end

    set --function CART_READER cartreader
    set --function CIPL cIPL
    set --function CLEANRIP CleanRip
    set --function DUMPLING dumpling
    set --function EPILOGUE Epilogue
    set --function GODMODE9 GodMode9
    set --function ISOBUSTER IsoBuster
    set --function MPF MPF
    set --function MULTIMAN multiMAN
    set --function NXDUMPTOOL NXDumpTool
    set --function RETROARCH RetroArch

    set --function _extra_path ""

    set --function system $argv[1]
    # The systems here are grouped by the program used to create the backups.
    # The more often I use it, the higher up in the list it appears.
    switch $system
        case atari2600
            set --function _dumper $CART_READER
            set --function _extension a26
        case coleco
            set --function _dumper $CART_READER
            set --function _extension col
        case gamegear
            set --function _dumper $CART_READER
            set --function _extension gg
        case genesis
            set --function _dumper $CART_READER
            set --function _extension md
        case mastersystem
            set --function _dumper $CART_READER
            set --function _extension sms
        case msx2
            set --function _dumper $CART_READER
            set --function _extension mx2
        case n64
            set --function _dumper $CART_READER
            set --function _extension z64
        case nes
            set --function _dumper $CART_READER
            set --function _extension nes
        case pcengine tg16
            set --function _dumper $CART_READER
            set --function _extension pce
        case sega32x
            set --function _dumper $CART_READER
            set --function _extension 32x
        case sfc snes
            set --function _dumper $CART_READER
            set --function _extension sfc

        case gb gba gbc
            set --function _dumper EPILOGUE
            set --function _extension $system

        case switch
            set --function _dumper NXDUMPTOOL
            set --function _extension nsp xci

        case wiiu
            set --function _dumper $DUMPLING
            set --function _extension wua
            set --function _extra_path /roms

        case gc wii
            set --function _dumper CLEANRIP
            set --function _extension rvz

        case pcenginecd psx saturn segacd
            set --function _dumper $RETROARCH
            set --function _extension chd m3u

        case ps2
            set --function _dumper $MPF
            set --function _extension chd

        case ps3
            set --function _dumper MULTIMAN
            set --function _extension ps3

        case psp
            set --function _dumper CIPL
            set --function _extension iso

        case n3ds
            set --function _dumper $GODMODE9
            set --function _extension 3ds cxi
        case nds
            set --function _dumper $GODMODE9
            set --function _extension nds

        case cdi
            set --function _dumper $ISOBUSTER
            set --function _extension chd

        case "*"
            echo "'$argv' is an unknown system"
            return 1
    end

    pushd $RETRO_GAMES/$system$_extra_path
    for f in $RETRO_BACKUPS/$_dumper/$system$_extra_path/*.{$_extension}
        ln -s -F -f -v $f
    end
    popd

    echo "Done."
end
