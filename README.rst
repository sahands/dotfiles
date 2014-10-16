"dotfiles" repository
======================
Mostly bash and vim configuration files, as well as some coding fonts, Mac OS
10 terminal schemes, and a couple of extra utils like duti (which sets default
applications for file types in Mac OS 10).

Use at your own risk. Some of the scripts might (probably *will*) overwrite
certain files and configurations.

Setting up config dot files
---------------------------
Run ``./scripts/create_sym_links.sh``.


Mac OS 10 setup
---------------
Make sure you have XCode, XCode Command Line Tools, and MacPorts installed.
Then run ``./scripts/mac_bootstrap.sh``. This will install duti, the extra
fonts, lots of ports, and set some ports to replace the default Mac OS 10 ones,
like python.
