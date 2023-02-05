#Solucionar problema con la hora
echo Resolviendo problema de la hora con dual boot
sudo timedatectl set-local-rtc 1

#install yay
echo Instalando yay
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER:users ./yay
cd yay
makepkg -si

#clonar dotfiles
echo Clonando dotfiles
git clone https://github.com/L2AsHdz/dotfiles.git ~/.dotfiles

#git config
ln -sv ~/.dotfiles/.gitconfig ~

# TODO: Actualizar llave ssh
# mkdir ~/.ssh
# sudo chmod 755 ~/.ssh
# ln -sv ~/.dotfiles/.ssh/id_ed25519.pub ~/.ssh
# sudo chmod 600 ~/.ssh/id_ed25519.pub
# ssh -T git@github.com

#python3
echo Instalando dependencias para ohmyzsh
sudo pacman -S python3

#autojump
yay -S autojump gitflow

#fzf
sudo pacman -S fzf
ENHANCD_FILTER=fzf; export ENHANCD_FILTER

#clonar ohwn-my-zsh
echo Clonando repositorio ohmyzsh
git clone git@github.com:L2AsHdz/ohmyzsh.git ~/.dotfiles/.oh-my-zsh
cd ~/.dotfiles/.oh-my-zsh
git checkout ohwn-my-zsh

#zsh
echo Instalando ohmyzsh
sudo pacman -S zsh
ln -sv ~/.dotfiles/.p10k.zsh ~
ln -sv ~/.dotfiles/.zshrc ~
ln -sv ~/.dotfiles/.zsh_history ~
chsh -s $(which zsh)

sh ~/.dotfiles/scripts/installPluginsZsh.sh
zsh
source ~/.zshrc
cd ~

# Parallel downloads pacman
sudo sed 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf

#fnm
echo Instalando fnm
curl -fsSL https://fnm.vercel.app/install | bash
src
fnm install 16
fnm use 16
node --version

#qtile configuration
ln -sv ~/.dotfiles/qtile/ ~/.config/qtile

#alacritty
pacin alacritty
ln -sv ~/.dotfiles/alacritty.yml ~/.config/alacritty

#tmux
pacin tmux
ln -sv ~/.dotfiles/.tmux.conf ~

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

#instalar varios paquetes de pacman
#dev
pacin jdk-openjdk tldr mysql-workbench guake jdk11-openjdk jdk8-openjdk maven postman
# pacin lua

#utils
pacin neofetch uget aria2 speedtest-cli exa bottom nmap wireshark-cli

#media
pacin vlc flameshot telegram-desktop pulseaudio-equalizer-ladspa libreoffice discord libreoffice-fresh-es
pacin hunspell hunspell-es_es hunspell-es_gt obs-studio
#system

pacin pacman-contrib gnome-keyring libsecret mesa-utils net-tools lshw nvidia-settings tree traceroute alsa-utils
pacin partitionmanager

#compress
pacin unrar zip unzip p7zip lzip arj sharutils lzop unace lrzip xz cabextract lha lz4 gzip bzip2

#fuentes
yain nerd-fonts-monoid nerd-fonts-inconsolata-go nerd-fonts-mononoki nerd-fonts-fira-code nerd-fonts-space-mono
yain nerd-fonts-overpass nerd-fonts-go-mono otf-nerd-fonts-fira-mono nerd-fonts-inconsolata nerd-fonts-jetbrains-mono

#instalar varios paquetes de yay
yain visual-studio-code-bin brave-bin google-chrome jetbrains-toolbox jdownloader2 spotify knemo downgrade teamviewer
yain zoom teams subnetcalc pgmodeler

#spotify-tui
yain spotify-tui

# Install angular-cli
npmg @angular/cli typescript
npmg npm-check-updates yarn

# qemu
pacin virt-manager qemu libvirt edk2-ovmf dnsmasq iptables-nft
sed 's/#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
sed 's/#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
sed 's/#\s*user = "libvirt-qemu"/user = "asael"/' /etc/libvirt/qemu.conf
sed 's/#\s*group = "libvirt-qemu"/group = "asael"/' /etc/libvirt/qemu.conf

#mariadb
pacin mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
ctlstart mysql
sudo mysql_secure_installation

#docker and docker-compose
pacin docker docker-compose
sudo usermod -aG docker $USER

#php
pacin apache
http_config='/etc/httpd/conf/httpd.conf'
sudo sed 's/LoadModule unique_id_module modules\/mod_unique_id.so/# LoadModule unique_id_module modules\/mod_unique_id.so/' $http_config
ctlstart httpd
ctlstat httpd


pacin php php-apache composer
sudo sed 's/LoadModule mpm_event_module modules\/mod_mpm_event.so/# LoadModule mpm_event_module modules\/mod_mpm_event.so/' $http_config
sudo sed 's/#LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/' $http_config

echo "
LoadModule php_module modules/libphp.so
AddHandler php-script php
Include conf/extra/php_module.conf
" >> $http_config

ctlrst httpd

#virtualbox
pacin virtualbox virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
sudo modprobe vboxdrv
yain virtualbox-ext-oracle

#neovim
pacin base-devel cmake unzip ninja tree-sitter curl
cd ~/Descargas
gcl https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Instalando dependencias
pacin ranger xsel ripgrep ueberzug the_silver_searcher bat git-delta lua fd ruby cppcheck jq
yain uncrustify beautysh luacheck
python -m ensurepip --upgrade
python -m pip install --upgrade pip
python3 -m pip install --user --upgrade pynvim
npmg neovim

# export GEM_PATH="$(ruby -e 'puts Gem.user_dir')"
# export PATH="$PATH:$GEM_PATH/bin"
# gem list
# gem update

gcl https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
ln -sv ~/.dotfiles/rc.conf ~/.config/ranger/

gcl https://github.com/L2AsHdz/LeoVim ~/.config/nvim

#Markdown Preview
cd ~/.local/share/nvim/site/pack/packer/start/
gcl https://github.com/iamcco/markdown-preview.nvim
cd markdown-preview.nvim/
yarn install
yarn build
