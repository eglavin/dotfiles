#!/bin/bash

ansible-galaxy collection install -r ./requirements.yml

become_args=()
# Ubuntu 25.10+ defaults to sudo-rs, which prints its own password prompt instead of the one
# Ansible passes with -p, so Ansible times out waiting for it. Use the original sudo instead.
if [ -x "$(command -v sudo.ws)" ]; then
	become_args+=(-e ansible_become_exe=sudo.ws)
fi

# Arguments are passed through, e.g. ./run.sh -vvv --skip-tags mise_tools
ansible-playbook ./main.yml --ask-become-pass "${become_args[@]}" "$@"
