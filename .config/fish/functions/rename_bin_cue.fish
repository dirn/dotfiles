function rename_bin_cue
    if test (count $argv) -lt 2
        echo "Both a source and destination are required."
        return 1
    else if test (count $argv) -gt 2
        echo "Too many arguments provided. Only source and destination are supported."
        return 1
    end

    for f in $argv[1]*.{bin,cue}
        mv $f (echo {$f} | sed "s/$argv[1]/$argv[2]/g")
    end

    sed -i "s/$argv[1]/$argv[2]/g" "$argv[2].cue"
end
