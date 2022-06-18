#Solucionar problema con la hora
sudo timedatectl set-local-rtc 1

#install yay
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R asael:users ./yay
cd yay
makepkg -si

#clonar dotfiles
git clone https://github.com/L2AsHdz/dotfiles.git

#git config
ln -sv ~/.dotfiles/.gitconfig ~

mkdir ~/.ssh
sudo chmod 755 ~/.ssh
ln -sv ~/.dotfiles/.ssh/id_ed25519.pub ~/.ssh
sudo chmod 600 ~/.ssh/id_ed25519.pub
ssh -T git@github.com

#python3
pacman -S python3

#autojump
yay -S autojump gitflow

#fzf
pacman -S fzf
ENHANCD_FILTER=fzf; export ENHANCD_FILTER

#clonar ohwn-my-zsh
git clone git@github.com:L2AsHdz/ohmyzsh.git ~/.dotfiles/.oh-my-zsh

#zsh
pacman -S zsh
ln -sv ~/.dotfiles/.p10k.zsh ~
ln -sv ~/.dotfiles/.zshrc ~
ln -sv ~/.dotfiles/.zsh_history ~
chsh -s $(which zsh)

~/.dotfiles/scripts/installPluginsZsh.sh
zsh
source ~/.zshrc

#fnm
curl -fsSL https://fnm.vercel.app/install | bash
src
fnm install 14
fnm use 14
node --version

#qtile configuration
mkdir -p ~/.config/qtile/settings/
qtile_cfg=~/.config/qtile
qtile_dot=~/.dotfiles/qtile
qtile_sttgs=$qtile_dot/settings
qtile_sttgs_2=$qtile_cfg/settings
ln -sv $qtile_dot/config.py $qtiledot
ln -sv $qtile_dot/autostart.sh $qtile_cfg

ln -sv $qtile_sttgs/keys.py $qtile_sttgs_2
ln -sv $qtile_sttgs/groups.py $qtile_sttgs_2
ln -sv $qtile_sttgs/layouts.py $qtile_sttgs_2
ln -sv $qtile_sttgs/screens.py $qtile_sttgs_2
ln -sv $qtile_sttgs/mouse.py $qtile_sttgs_2

#alacritty
ln -sv ~/.dotfiles/alacritty.yml ~/.config/alacritty

#instalar varios paquetes de pacman
pacin neofetch jdk-openjdk vlc pacman-contrib gnome-keyring libsecret flameshot uget aria2 tldr speedtest-cli telegram-desktop exa docker docker-compose mesa-utils pulseaudio-equalizer-ladspa mysql-workbench libreoffice net-tools lshw
pacin unrar zip unzip p7zip lzip arj sharutils lzop unace lrzip xz cabextract lha lz4 gzip bzip2 maven

#fuentes
yain nerd-fonts-monoid nerd-fonts-inconsolata-go nerd-fonts-mononoki nerd-fonts-fira-code nerd-fonts-space-mono nerd-fonts-overpass nerd-fonts-go-mono otf-nerd-fonts-fira-mono nerd-fonts-inconsolata nerd-fonts-jetbrains-mono

#instalar varios paquetes de yay
yain visual-studio-code-bin brave-bin google-chrome jetbrains-toolbox jdownloader2 spotify knemo downgrade

#spotify-tui
yain spotify-tui

#mariadb
pacin mariadb
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
ctlstart mysql
sudo mysql_secure_installation

#docker and docker-compose
pacin docker docker-compose
sudo usermod -aG docker $USER

#virtualbox
pacin virtualbox virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
sudo modprobe vboxdrv
yain virtualbox-ext-oracle

#neovim
pacin neovim ranger xsel ripgrep ueberzug the_silver_searcher bat git-delta lua fd ruby cppcheck vint jq
yain uncrustify stylua shfmt luacheck
python -m ensurepip --upgrade
python -m pip install --upgrade pip
python3 -m pip install --user --upgrade pynvim
npmg neovim @fsouza/prettierd eslint_d

export GEM_PATH="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_PATH/bin"
gem list
gem update

# Install angular-cli
npmg @angular/cli typescript
npmg npm-check-updates yarn

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
ln -sv ~/.dotfiles/rc.conf ~/.config/ranger/

#Markdown Preview
cd ~/.local/share/nvim/site/pack/packer/start/
gcl https://github.com/iamcco/markdown-preview.nvim
cd markdown-preview.nvim/
yarn install
yarn build

mkdir -p ~/.config/nvim
nvimcfg=~/.config/nvim
nvimdot=~/.dotfiles/nvim
nvim_lua_cfg2=$nvimdot/lua/config
nvim_lua_cfg=$nvimcfg/lua/config
ln -sv $nvimdot/maps.vim $nvimcfg
ln -sv $nvimdot/plugin-config.vim $nvimcfg

mkdir $nvimcfg/lua
mkdir -p $nvim_lua_cfg/lsp/settings
ln -sv $nvimdot/init.lua $nvimcfg
ln -sv $nvimdot/lua/settings.lua $nvimcfg/lua
ln -sv $nvimdot/lua/plugins.lua $nvimcfg/lua
ln -sv $nvimdot/lua/utils.lua $nvimcfg/lua
ln -sv $nvimdot/lua/maps.lua $nvimcfg/lua
ln -sv $nvimdot/lua/autocommands.lua $nvimcfg/lua

ln -sv $nvim_lua_cfg2/lsp/init.lua $nvim_lua_cfg/lsp
ln -sv $nvim_lua_cfg2/lsp/handlers.lua $nvim_lua_cfg/lsp
ln -sv $nvim_lua_cfg2/lsp/lsp-installer.lua $nvim_lua_cfg/lsp
ln -sv $nvim_lua_cfg2/lsp/settings/jsonls.lua $nvim_lua_cfg/lsp/settings
ln -sv $nvim_lua_cfg2/lsp/settings/sumneko_lua.lua $nvim_lua_cfg/lsp/settings

ln -sv $nvim_lua_cfg2/cmp.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/treesitter.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/null-ls.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/lualine.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/neogit.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/blankline.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/gitsigns.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/nvim-tree.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/sidebar.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/bufferline.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/colorscheme.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/autosave.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/telescope.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/startify.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/autopairs.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/term.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/project.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/alpha.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/session.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/notify.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/dressing.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/whichkey.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/flutter.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/cursorline.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/comment.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/ts-context.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/rest.lua $nvim_lua_cfg
ln -sv $nvim_lua_cfg2/code-runner.lua $nvim_lua_cfg

#tlp
pacin tlp tlp-rdw
ctlon tlp
ctlon NetworkManager-dispatcher
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
sudo tlp start

#TRIM for SSD
ctlon fstrim.timer
ctlstart fstrim.timer
