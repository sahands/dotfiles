# Pull all git submodules
git submodule update --init dotfiles/vim/bundle/*
git submodule update --init utils/*
git submodule foreach git pull origin master
