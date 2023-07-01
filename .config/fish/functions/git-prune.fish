# This is derived from https://gist.github.com/robmiller/5133264. It has been
# adapted to only delete local branches (since I have git prune remote branches
# by default) and to echo the command to restore each branch in case one is
# needed again for some reason.

function git-prune
    set -l CURRENT_BRANCH (git rev-parse --abbrev-ref HEAD)
    if test "$CURRENT_BRANCH" != main
        echo "git-prune must be run from main"
        return 1
    end

    git fetch

    set -l MERGED (git branch --merged origin/main | grep -v 'main$' | string trim)
    if test -z "$MERGED"
        echo "There are no branches that have been merged."
        return
    end

    echo "The following branches have been merged and will be removed:"
    echo
    for branch in $MERGED
        echo \t$branch
    end
    echo
    read --function --prompt-str "Continue [yN]? " REPLY
    if test (string lower "$REPLY") != y
        return
    end

    echo "Your branches are being deleted. You can restore them with:"
    echo
    for branch in $MERGED
        set -l HASH (git rev-parse $branch)
        echo \tgit switch --create $branch $HASH
        git branch --quiet --delete $branch
    end
    echo

    echo done
end
