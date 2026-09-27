#!/bin/bash

ansible-galaxy collection install -r ./requirements.yml

# Arguments are passed through, e.g. ./run.sh -vvv --skip-tags mise_tools
ansible-playbook ./main.yml --ask-become-pass "$@"
