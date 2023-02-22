function convert2chd
    if test -z $argv[1]
        echo "A file extension is required."
        return 1
    end
    for f in *.$argv[1]
        set -l chd (basename $f .$argv[1])
        chdman createcd -i "$f" -o "$chd.chd"
    end
end
