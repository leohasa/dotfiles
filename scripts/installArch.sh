#Actualizar hora de la computadora
timedatectl set-ntp true

#Configurar mirrors
pacman -Sy
cp -vf /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

#Actualizar repositorios
pacman -Syyy

#Particionamiento, formateo y montaje
lsblk
cfdisk /dev/loquesea

#particiones root y home
mkfs.ext4 /dev/particion
#particion efi
mkfs.fat -F 32 /dev/partition
#particion swap
mkswap /dev/partition
swapon /dev/partition

#montar root
mount /dev/partition /mnt
#montar efi
mkdir /mnt/efi
mount /dev/partition /mnt/efi
#montar home
mkdir /mnt/home
mount /dev/partition /mnt/home
#montar otras particiones
mkdir /mnt/W10
mount /dev/partition /mnt/W10

#Instalacion de paquetes base
pacstrap /mnt base linux-lts linux-firmware nano neovim intel-ucode

#Generacion de archivo para montar particiones automaticamente
genfstab -U /mnt >> /mnt/etc/fstab

#Emular sistema en /mnt
arch-chroot /mnt

# Buscar zona horaria
# America/Guatemala
timedatectl list-timezones

#Crear enlace simbolico localtime
ln -sf /usr/share/zoneinfo/America/Guatemala /etc/localtime
hwclock --systohc

#Descomentar: es_GT.UTF-8 UTF-8
nano /etc/locale.gen

#Generar archivo con configuracion de idioma
locale-gen
echo "LANG=es_GT.UTF-8" >> /etc/locale.conf

#Configuracion de hotsname y hosts
#Escribir nombre de la maquina
echo "hostname" >> /etc/hostname

nano /etc/hosts
#Escribir lo siguiente
127.0.0.1       localhost
::1             localhost
127.0.1.1       namePC

#Crear contraseña root
passwd

#Instalacion de paquetes
pacman -S grub efibootmgr os-prober ntfs-3g networkmanager openssh base-devel linux-lts-headers git

#Configuracion de grub
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#Habilitar servicios
systemctl enable NetworkManager
systemctl enable sshd

#Crear usuario
useradd -mG wheel,audio,video,storage username
passwd username

#Descomentar wheel ALL=(ALL) ALL
EDITOR=nano visudo

exit
umount -a
reboot

# Instalando KDE
pacman -S network-manager-applet wireless_tools dialog
pacman -S mtools dosfstools bluez bluez-utils pulseaudio-bluetooth cups

#Iniciar servicios
systemctl enable bluetooth
systemctl enable cups

#Conectar a wifi
nmtui

#Drivers de vídeo
pacman -S nvidia-lts nvidia-utils

#Servidor grafico
pacman -S xorg
#or
pacman -S xorg-server

#SDDM
pacman -S sddm
systemctl enable sddm

#Instalacion de plasma y kde-applications
pacman -S plasma packagekit-qt5
pacman -S plasma-desktop packagekit-qt5

#or
pacman -S bluedevil breeze-gtk kde-gtk-config khotkeys kinfocenter kscreen ksshaskpass kwallet-pam plasma-browser-integration plasma-desktop plasma-nm plasma-pa plasma-systemmonitor powerdevil sddm-kcm

pacman -S ktouch gwenview kcolorchooser okular kamoso kdeconnect dolphin dolphin-plugins ark filelight kate kcalc kfind konsole partitionmanager
