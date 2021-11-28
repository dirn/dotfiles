function beesync --description "Sync retro saves from my retro game box"
    if test -z "$RETRO_SAVES"
        echo "\$RETRO_SAVES not set"
        return 1
    else if not test -e $RETRO_SAVES
        echo "'$RETRO_SAVES' not found"
        return 1
    end

    # save files
    rsync \
        --archive \
        --progress \
        --update \
        --relative \
        beelink:"~/roms/./*/*.srm" \
        beelink:~/roms/savestates/ \
        $RETRO_SAVES
end
