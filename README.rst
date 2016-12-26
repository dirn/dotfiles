############
Hello there!
############

Thanks for checking out my dotfiles. If you want to use them, feel free to clone
and repo and play around. If you want to setup up your computer with some useful
(at least to me) stuff, they can take care of that for you. Installation is
easy. Here's what you'll need to get started:

* `Xcode command line tools`_
* `An SSH key registered with GitHub`_
* `pip`_

.. _Xcode command line tools: https://developer.apple.com/library/ios/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588-CH1-DOWNLOADING_COMMAND_LINE_TOOLS_IS_NOT_AVAILABLE_IN_XCODE_FOR_OS_X_10_9__HOW_CAN_I_INSTALL_THEM_ON_MY_MACHINE_
.. _An SSH key registered with GitHub: https://help.github.com/articles/generating-ssh-keys/
.. _pip: https://pip.pypa.io/en/latest/installing.html

Once you have these, install Ansible::

    $ python -m pip install --user ansible

Then grab a version of the playbook that can be used for its initial run::

    $ curl -1 https://raw.githubusercontent.com/dirn/dotfiles/master/playbook.yml > /tmp/playbook.yml
    $ ~/path/to/bin/ansible-playbook --ask-sudo-pass --inventory-file localhost, --connection=local /tmp/playbook.yml

After the initial run, the playbook can be run again with::

    $ play

Caution
#######

There are places where I will reference information specific to me, such as the
``.gitconfig`` file. If you use these dotfiles, make sure you update the
references to use your information.
