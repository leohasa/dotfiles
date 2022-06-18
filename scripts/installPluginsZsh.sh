#!/bin/bash
OZSHC=~/.dotfiles/.oh-my-zsh/custom

cd $OZSHC/themes

git clone git@github.com:romkatv/powerlevel10k.git

cd $OZSHC/plugins

git clone git@github.com:lukechilds/zsh-nvm.git

git clone git@github.com:b4b4r07/enhancd.git

git clone git@github.com:zsh-users/zsh-autosuggestions.git

git clone git@github.com:zsh-users/zsh-syntax-highlighting.git

git clone git@github.com:zsh-users/zsh-history-substring-search.git

git clone git@github.com:zsh-users/zsh-completions.git

git clone git@github.com:akarzim/zsh-docker-aliases.git

git clone git@github.com:zpm-zsh/mysql-colorize.git

git clone git@github.com:supercrabtree/k.git
