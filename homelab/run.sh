#!/bin/bash

cd "$(dirname "$0")" || exit 1

# Ansible ignores ansible.cfg in a world-writable working directory, which every /mnt/c path is under WSL
export ANSIBLE_CONFIG="$PWD/ansible.cfg"

if [ ! -f inventory.ini ]; then
	echo "inventory.ini not found, copy inventory.ini.example and add your hosts"
	exit 1
fi

# Arguments are passed through, e.g. ./run.sh --check or ./run.sh --limit webserver
ansible-playbook ./update.yml "$@"
