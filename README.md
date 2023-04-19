# dotfiles

Thanks for checking out my dotfiles. If you want to use them, feel free to clone
and repo and play around. If you want to setup up your computer with some useful
(at least to me) stuff, they can take care of that for you.

## Setup

This repository is managed by [Yet Another Dotfiles Manager][yadm]. To add it to
a new computer:

    $ git clone https://github.com/TheLocehiliosan/yadm.git ~/.yadm-project
    $ ~/.yadm-project/yadm clone -b main https://gitlab.com/dirn/dotfiles.git --bootstrap
    $ rm -rf ~/.yadm-project

### macOS

    $ sudo xcode-select --install

[`mas`][mas] is used to manage applications installed through the App Store.
Before it can be installed, though, Xcode needs to be installed through the App
Store. Its license must be accepted; this can be done through the command line:

    $ sudo xcodebuild -license accept

If using an ARM-based processor, Rosetta 2 is required to run anything that is
only available for x86-based processors.

    $ /usr/sbin/softwareupdate --install-rosetta --agree-to-license

### pre-commit

This repository uses [pre-commit] to keep the files nicely formatted. pre-commit
and yadm play together nicely when committing, but since yadm stores the git
repository away from the working copy, anytime `pre-commit` is invoked, it needs
to be told where the repository is.

    $ env GIT_DIR=$HOME/.local/share/yadm/repo.git pre-commit install

#### GNU

macOS ships with the BSD version of some tools rather than the [GNU] version.
For some of the GNU tools that it does include, they're out-of-date. Up-to-date
GNU versions of [these tools][gnuclt] will be installed. Some other out-of-date
tools will be updated as well.

[gnu]: https://www.gnu.com
[gnuclt]: https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
[mas]: https://github.com/mas-cli/mas
[pre-commit]: https://pre-commit.com
[yadm]: https://yadm.io
