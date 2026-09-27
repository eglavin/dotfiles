#!/bin/bash

verbose="false"

while getopts v flag
do
	case "${flag}" in
		v) verbose="true" ;;
	esac
done

ansible-galaxy collection install -r ./requirements.yml

if [ $verbose = "true" ]; then
	ansible-playbook ./main.yml --ask-become-pass -vvv
else
	ansible-playbook ./main.yml --ask-become-pass
fi
