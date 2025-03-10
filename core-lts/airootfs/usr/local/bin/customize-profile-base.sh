#!/bin/bash

# Executa o comando locale-gen para gerar as configurações de localização
locale-gen

# Executa o comando systemctl para habilitar o NetworkManager
systemctl enable NetworkManager

# Popula repositórios
pacman-key --init

# Habilita o SDDM para o Plasma
systemctl enable sddm.service

# Habilita o Bluetooth
# systemctl enable bluetooth

## Script to perform several important tasks before `mkarchiso` create filesystem image.

set -e -u

## -------------------------------------------------------------- ##

sed -i '/etc/mkinitcpio.conf' \
	-e "s/#COMPRESSION=\"xz\"/COMPRESSION=\"xz\"/g"


## Fix Initrd Generation in Installed System
cat > "/etc/mkinitcpio.d/linux.preset" <<- _EOF_
	# mkinitcpio preset file for the 'linux' package

	ALL_kver="/boot/vmlinuz-linux"
	ALL_config="/etc/mkinitcpio.conf"

	PRESETS=('default' 'fallback')

	#default_config="/etc/mkinitcpio.conf"
	default_image="/boot/initramfs-linux.img"
	#default_options=""

	#fallback_config="/etc/mkinitcpio.conf"
	fallback_image="/boot/initramfs-linux-fallback.img"
	fallback_options="-S autodetect"    
_EOF_

## Delete ISO specific init files
rm -rf /etc/mkinitcpio.conf.d
