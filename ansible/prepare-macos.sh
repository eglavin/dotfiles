#!/bin/bash

if [ ! -x "$(command -v brew)" ]; then
	echo "brew should be installed before running this command"
	echo "Visit: https://brew.sh/ to install"
	exit 1
fi

brew install ansible
