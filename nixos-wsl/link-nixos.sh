#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi


user=$(logname)
HOME=$(eval echo "~$user")


# Backup the following files if they exist and are not symlinks:
# "/etc/nixos/configuration.nix"
# "/etc/nixos/hardware-configuration.nix"
# Then create symlinks to the corresponding files in the user's dotfiles directory.

if [ -f /etc/nixos/configuration.nix ]; then
	if [ ! -L /etc/nixos/configuration.nix ]; then
		echo "Backing up existing /etc/nixos/configuration.nix to /etc/nixos/configuration.nix.bak"
		mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
	else
		rm /etc/nixos/configuration.nix
	fi

	ln -s $HOME/dotfiles/nixos-wsl/configuration.nix /etc/nixos/configuration.nix
fi


if [ -f /etc/nixos/hardware-configuration.nix ]; then
	if [ ! -L /etc/nixos/hardware-configuration.nix ]; then
		echo "Backing up existing /etc/nixos/hardware-configuration.nix to /etc/nixos/hardware-configuration.nix.bak"
		mv /etc/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix.bak
	else
		rm /etc/nixos/hardware-configuration.nix
	fi

	ln -s $HOME/dotfiles/nixos-wsl/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
fi

echo "Symlinks created successfully."
