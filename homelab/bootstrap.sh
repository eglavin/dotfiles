#!/bin/bash

cd "$(dirname "$0")" || exit 1

# Ansible ignores ansible.cfg in a world-writable working directory, which every /mnt/c path is under WSL
export ANSIBLE_CONFIG="$PWD/ansible.cfg"

if [ ! -f inventory.ini ]; then
	echo "inventory.ini not found, copy inventory.ini.example and add your hosts"
	exit 1
fi

key="$HOME/.ssh/ansible_homelab"

if [ ! -f "$key" ]; then
	echo "Creating SSH key $key"
	mkdir -p "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"
	# The comment names this machine in authorized_keys, which is how bootstrap.yml revokes it later
	ssh-keygen -t ed25519 -f "$key" -C "ansible@$(hostname -s)" || exit 1
fi

# The playbook's last task logs in with the new key, so a passphrase has to be entered here rather than mid-run
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent -s)" > /dev/null
	trap 'ssh-agent -k > /dev/null' EXIT
fi
ssh-add "$key" || exit 1

# Arguments are passed through, e.g. ./bootstrap.sh --limit hypervisor, ./bootstrap.sh --ask-pass
# or ./bootstrap.sh -e revoke=old-laptop to remove another control machine's key
ansible-playbook ./bootstrap.yml --ask-become-pass "$@"
