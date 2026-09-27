#!/bin/bash

verbose="false"

while getopts v flag
do
	case "${flag}" in
		v) verbose="true" ;;
	esac
done
shift $((OPTIND - 1))

ansible-galaxy collection install -r ./requirements.yml

# Any remaining arguments are passed through, e.g. ./run.sh --skip-tags mise_tools
if [ $verbose = "true" ]; then
	ansible-playbook ./main.yml --ask-become-pass -vvv "$@"
else
	ansible-playbook ./main.yml --ask-become-pass "$@"
fi
