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

## Script to perform several important tasks before `corelinuxiso` create filesystem image.

set -e -u

## -------------------------------------------------------------- ##
## Modify /etc/mkinitcpio.conf file
sed -i '/etc/mkinitcpio.conf' \
	-e "s/microcode/microcode plymouth/g" \
	-e "s/#COMPRESSION=\"xz\"/COMPRESSION=\"xz\"/g"

rm -rf /etc/mkinitcpio.conf.d

## -------------------------------------------------------------- ##

## Enable Parallel Downloads
sed -i -e 's|#ParallelDownloads.*|ParallelDownloads = 10|g' /etc/pacman.conf

