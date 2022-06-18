#Actualizar hora de la computadora
timedatectl set-ntp true

#Configurar mirrors
pacman -Sy
# pacman -S reflector
cp -vf /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

#Actualizar repositorios
pacman -Syyy

#Particionamiento, formateo y montaje
lsblk
cfdisk /dev/loquesea
- Crear particiones
mkfs.ext4 /dev/particion  //root
mkfs.ext4 /dev/particion  //home
mkswap /dev/partition
swapon /dev/partition

mount /dev/partition /mnt   //root
mkdir /mnt/efi
mount /dev/partition /mnt/efi
mkdir /mnt/home
mount /dev/partition /mnt/home
mkdir /mnt/W10
mount /dev/partition /mnt/W10

#Instalacion de paquetes base
pacstrap /mnt base linux-lts linux-firmware nano intel-ucode

#Generacion de archivo para montar particiones automaticamente
genfstab -U /mnt >> /mnt/etc/fstab

#Emular sistema en /mnt
arch-chroot /mnt

#Buscar zona horaria
timedatectl list-timezones   -  America/Guatemala

#Crear enlace simbolico localtime
ln -sf /usr/share/zoneinfo/America/Guatemala /etc/localtime
hwclock --systohc

#Descomentar idioma
#Descomentar es_GT.UTF-8 UTF-8
nano /etc/locale.gen

#Generar archivo con configuracion de idioma
locale-gen
echo "LANG=es_GT.UTF-8" >> /etc/locale.conf

#Configuracion de hotsname y hosts
#Escribir nombre de la maquina
nano /etc/hostname 

nano /etc/hosts
#Escribir lo siguiente
127.0.0.1       localhost
::1             localhost
127.0.1.1       namePC.localdomain      namePC

#Crear contraseña root
passwd

#Instalacion de paquetes
pacman -S grub efibootmgr os-prober ntfs-3g networkmanager network-manager-applet wireless_tools wpa_supplicant dialog mtools dosfstools base-devel linux-lts-headers git bluez bluez-utils pulseaudio-bluetooth cups openssh

#Configuracion de grub
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
echo "GRUB_DISABLE_OS_PROBER=false" >> nano /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#Iniciar servicios
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable sshd

#Crear usuario
useradd -mG wheel username
passwd username

#Descomentar wheel ALL=(ALL) ALL
EDITOR=nano visudo 

exit
umount -a
reboot

#Conectar a wifi
nmtui

#Drivers de vídeo
pacman -S nvidia nvidia-utils

#Servidor grafico
pacman -S xorg

#SDDM
pacman -S sddm
systemctl enable sddm

#Instalacion de plasma y kde-applications
pacman -S plasma packagekit-qt5

ktouch gwenview kcolorchooser okular kamoso kdeconnect dolphin dolphin-plugins ark filelight kate kcalc kfind konsole
