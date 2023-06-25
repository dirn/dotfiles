function retro_link
    if test -z "$RETRO_BACKUPS"
        echo "\$RETRO_BACKUPS not set"
        return 1
        elif test -z "$RETRO_GAMES"
        echo "\$RETRO_GAMES not set"
        return 1
    end

    set --local CART_READER cartreader
    set --local CIPL cIPL
    set --local CLEANRIP CleanRip
    set --local DUMPLING dumpling
    set --local EPILOGUE Epilogue
    set --local GODMODE9 GodMode9
    set --local ISOBUSTER IsoBuster
    set --local MPF MPF
    set --local MULTIMAN multiMAN
    set --local NXDUMPTOOL NXDumpTool
    set --local RETROARCH RetroArch

    set --global _extra_path ""

    set --local system $argv[1]
    # The systems here are grouped by the program used to create the backups.
    # The more often I use it, the higher up in the list it appears.
    switch $system
        case atari2600
            set --global _dumper $CART_READER
            set --global _extension a26
        case coleco
            set --global _dumper $CART_READER
            set --global _extension col
        case gamegear
            set --global _dumper $CART_READER
            set --global _extension gg
        case genesis
            set --global _dumper $CART_READER
            set --global _extension md
        case mastersystem
            set --global _dumper $CART_READER
            set --global _extension sms
        case n64
            set --global _dumper $CART_READER
            set --global _extension z64
        case nes
            set --global _dumper $CART_READER
            set --global _extension nes
        case pcengine tg16
            set --global _dumper $CART_READER
            set --global _extension pce
        case sega32x
            set --global _dumper $CART_READER
            set --global _extension 32x
        case sfc snes
            set --global _dumper $CART_READER
            set --global _extension sfc

        case gb gba gbc
            set --global _dumper EPILOGUE
            set --global _extension $system

        case switch
            set --global _dumper NXDUMPTOOL
            set --global _extension nsp xci

        case wiiu
            set --global _dumper $DUMPLING
            set --global _extension wua
            set --global _extra_path /roms

        case gc wii
            set --global _dumper CLEANRIP
            set --global _extension rvz

        case pcenginecd psx saturn segacd
            set --global _dumper $RETROARCH
            set --global _extension chd m3u

        case ps2
            set --global _dumper $MPF
            set --global _extension chd

        case ps3
            set --global _dumper MULTIMAN
            set --global _extension ps3

        case psp
            set --global _dumper CIPL
            set --global _extension iso

        case n3ds
            set --global _dumper $GODMODE9
            set --global _extension 3ds cxi
        case nds
            set --global _dumper $GODMODE9
            set --global _extension nds

        case cdi
            set --global _dumper $ISOBUSTER
            set --global _extension chd

        case "*"
            echo "'$argv' is an unknown system"
            return 1
    end

    pushd $RETRO_GAMES/$system$_extra_path
    for f in $RETRO_BACKUPS/$_dumper/$system$_extra_path/*.{$_extension}
        ln -s -F -f -v $f
    end
    popd

    set --erase _dumper
    set --erase _extension
    set --erase _extra_path

    echo "Done."
end
