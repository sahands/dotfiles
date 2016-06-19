"dotfiles" repository
======================
Mostly bash and vim configuration files, as well as some coding fonts, and Mac
OS 10 terminal schemes.

Use at your own risk. Some of the scripts might (probably *will*) overwrite
certain files and configurations.

Setting up config dot files
---------------------------
User configuration files such `.bash_profile` will be set up by creating
symbolic links to the files in the repository. You can run
``./scripts/create_sym_links.sh`` to set up the symbolic links.

Mac OS 10 setup
---------------
Make sure you have XCode, XCode Command Line Tools, and MacPorts installed.
Then run ``./scripts/mac_bootstrap.sh``. This will install the extra fonts,
some ports, and set some ports to replace the default Mac OS 10 ones, like
python.
