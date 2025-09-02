#!/bin/bash
OZSHC=~/.dotfiles/.oh-my-zsh/custom

mkdir -p $OZSHC/themes
cd $OZSHC/themes

git clone https://github.com/romkatv/powerlevel10k.git

mkdir -p cd $OZSHC/plugins
cd $OZSHC/plugins

git clone https://github.com/lukechilds/zsh-nvm.git

git clone https://github.com/b4b4r07/enhancd.git

git clone https://github.com/zsh-users/zsh-autosuggestions.git

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

git clone https://github.com/zsh-users/zsh-history-substring-search.git

git clone https://github.com/zsh-users/zsh-completions.git

git clone https://github.com/akarzim/zsh-docker-aliases.git

git clone https://github.com/zpm-zsh/mysql-colorize.git

git clone https://github.com/supercrabtree/k.git
