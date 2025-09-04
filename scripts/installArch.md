# Guía de Instalación de Arch Linux
## Instalación base
### 1. Configuración inicial
```bash
timedatectl set-ntp true
```

### 2. Configurar mirrors
```bash
pacman -Sy
cp -vf /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
```

### 3. Actualizar repositorios
```bash
pacman -Syyy
```

### 4. Particionamiento
Verifica los discos disponibles:
```bash
lsblk
```
Crea las particiones necesarias (root, home, efi, swap, etc.):
```bash
cfdisk /dev/{nvmeXnX}
```

### 5. Formateo de particiones

#### Establecer nombre de cada particion
```bash
gdisk /dev/nvmeXnX
# p para imprimir tabla de particiones
# c para cambiar nombre
# w para guardar cambios
```

#### Ejemplo EXT4
```bash
mkfs.ext4 /dev/{nvmeXnXpX}
e2label /dev/{nvmeXnXpX} "Arch Linux"
```

#### Ejemplo BTRFS
```bash
mount /dev/{nvmeXnXpX} /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o subvol=@ /dev/{nvmeXnXpX} /mnt
mount --mkdir -o subvol=@home /dev/{nvmeXnXpX} /mnt/home
mount --mkdir -o subvol=@snapshots /dev/{nvmeXnXpX} /mnt/.snapshots
sudo btrfs filesystem label /dev/{nvmeXnXpX} "Arch Linux"
```

#### EFI
```bash
mkfs.fat -F32 /dev/{nvmeXnXpX}
dosfslabel /dev/{nvmeXnXpX} "ESP"
```

#### Swap
```bash
mkswap -L Swap /dev/{nvmeXnXpX}
swapon /dev/{nvmeXnXpX}
```

### 6. Montar particiones
```bash
mount /dev/{root_partition} /mnt
mount --mkdir /dev/{efi_partition} /mnt/efi
mount --mkdir /dev/{home_partition} /mnt/home
mount --mkdir /dev/{windows_partition} /mnt/W10
mount --mkdir /dev/{another-partition} /mnt/another
```

### 7. Instalación de paquetes base
```bash
pacstrap /mnt base linux-lts linux-firmware nano neovim intel-ucode btrfs-progs git
```

### 8. Configuración del sistema base
Generar `fstab`:
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```
Entrar al nuevo sistema:
```bash
arch-chroot /mnt
```
#### Zona horaria
```bash
timedatectl list-timezones | grep America/Guatemala
ln -sf /usr/share/zoneinfo/America/Guatemala /etc/localtime
hwclock --systohc
```
#### Idioma
```bash
sed -i 's/#es_GT.UTF-8 UTF-8/es_GT.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=es_GT.UTF-8" > /etc/locale.conf
```

#### Hostname
```bash
echo "hostname" > /etc/hostname
```

Editar `/etc/hosts`:
```
127.0.0.1   localhost
::1         localhost
127.0.1.1   hostname.localdomain  hostname
```

#### Contraseña root
```bash
passwd
```

### 9. Paquetes adicionales
Estos paquetes son necesarios para la funcionalidad básica del sistema.
```bash
pacman -S grub efibootmgr os-prober ntfs-3g networkmanager openssh base-devel linux-lts-headers mtools dosfstools bluez bluez-utils cups less gdisk
```

### 10. Configuración de GRUB
```bash
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
```

### 11. Habilitar servicios
```bash
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable bluetooth
systemctl enable cups
```

### 12. Crear usuario
```bash
useradd -mG wheel,audio,video,storage -s /bin/bash {username}
passwd {username}
EDITOR=nvim visudo   # Descomentar: %wheel ALL=(ALL) ALL
```

### 13. Finalizar instalación
```bash
exit
umount -R /mnt
reboot
```

## Instalación de Entorno Gráfico
### Configuraciones iniciales
#### Audio
##### Pipewire (Recomendado)
```bash
pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
systemctl --user enable --now pipewire pipewire-pulse
```
##### Alsa
```bash
sudo pacman -S pulseaudio pulseaudio-alsa alsa-utils pulseaudio-bluetooth
```

#### Drivers gráficos
Ajustar según GPU [OficialGuide](https://wiki.archlinux.org/title/Xorg#Driver_installation)

```bash
pacman -S nvidia-lts nvidia-utils
```

#### Servidor gráfico
```bash
pacman -S xorg-server xorg-xinit xorg-xauth
```

#### Display Manager
##### SDDM
```bash
pacman -S sddm
systemctl enable sddm
```

##### Ly
```bash
pacman -S ly brightnessctl
systemctl enable ly
```

#### Escritorio
##### KDE Plasma
```bash
pacman -S plasma plasma-desktop packagekit-qt5 kde-applications
```

```bash
pacman -S dolphin konsole gwenview okular kate kdeconnect ark filelight partitionmanager
```

##### Budgie
```bash
pacman -S budgie-desktop budgie-screensaver budgie-control-center budgie-session
```

##### Cinnamon
```bash
pacman -S cinnamon
```

### Configuración Post-Instalación
#### Yay (AUR Helper)
```bash
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER:users ./yay
cd yay
makepkg -si
```

#### Paquetes de compresión
```bash
pacman -S unrar zip unzip p7zip lzip arj sharutils lzop unace lrzip xz cabextract lha lz4 gzip bzip2
```

#### Utilidades recomendadas
```bash
pacman -S neofetch tree traceroute htop btop nmap pacman-contrib net-tools lshw jq mtr speedtest-cli bottom wireshark-cli 
```

#### TLP (gestión de energía en laptops)
```bash
pacman -S tlp tlp-rdw
systemctl enable tlp
systemctl enable NetworkManager-dispatcher
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
sudo tlp start
```

#### TRIM para SSD
```bash
systemctl enable fstrim.timer
systemctl start fstrim.timer
```

### Configuración de pacman
#### ParallelDownloads
```bash
grep -q '^[#]*ParallelDownloads' /etc/pacman.conf \
  && sudo sed -i 's/^#ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf \
  || echo 'ParallelDownloads = 5' | sudo tee -a /etc/pacman.conf
```

#### ILoveCandy
```bash
grep -q '^[#]*ILoveCandy' /etc/pacman.conf \
  && sudo sed -i 's/^#ILoveCandy/ILoveCandy/' /etc/pacman.conf \
  || echo 'ILoveCandy' | sudo tee -a /etc/pacman.conf
```

#### Color
```bash
grep -q '^[#]*Color' /etc/pacman.conf \
  && sudo sed -i 's/^#Color/Color/' /etc/pacman.conf \
  || echo 'Color' | sudo tee -a /etc/pacman.conf
```

#### VerbosePkgLists
```bash
grep -q '^[#]*VerbosePkgLists' /etc/pacman.conf \
  && sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf \
  || echo 'VerbosePkgLists' | sudo tee -a /etc/pacman.conf

```



